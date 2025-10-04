(uiop:define-package #:sento-cron/schedule
  (:use #:cl)
  (:import-from #:cl-telegram-bot2/debug)
  (:import-from #:local-time
                #:now
                #:parse-timestring)
  (:import-from #:sento.actor-system
                #:make-actor-system)
  (:import-from #:sento.actor-context
                #:actor-of)
  (:import-from #:log4cl-extras/error
                #:with-log-unhandled)
  (:import-from #:serapeum
                #:soft-list-of
                #:->
                #:eval-always)
  (:import-from #:local-time-duration
                #:timestamp-difference)
  (:import-from #:humanize-duration
                #:humanize-duration)
  (:import-from #:sento-cron/task
                #:task
                #:task-timer
                #:task-actor
                #:task-func
                #:task-delay)
  (:export #:defschedule
           #:schedule
           #:schedule-system
           #:external-system-p
           #:schedule-tasks
           #:scheduler-is-running
           #:status
           #:start-scheduler
           #:stop-scheduler))
(in-package #:sento-cron/schedule)


(eval-always
  (defclass schedule ()
    ((system :initform nil
             :reader schedule-system)
     (external-system-p :initform nil
                        :type boolean
                        :reader external-system-p
                        :documentation "If T, then actor system in slot SYSTEM was given to the function START-SCHEDULER.")
     (tasks :initarg :tasks
            :reader schedule-tasks
            :type (soft-list-of task))
     (running :initform nil
              :type boolean
              :reader scheduler-is-running)))
  
  (defun make-schedule (clauses)
    (loop for (delay func) in clauses
          collect (make-instance 'task
                                 :delay delay
                                 :func func)
            into tasks
          finally (return (make-instance 'schedule
                                         :tasks tasks)))))


(defun actor-queue-size (actor)
  (queue:queued-count 
   (slot-value
    (sento.actor-cell:msgbox actor)
    'sento.messageb::queue)))


(defun stop-scheduler (schedule &key (wait t))
  (when (scheduler-is-running schedule)
    ;; First we need to stop triggering new tasks
    (loop for task in (schedule-tasks schedule)
          when (task-timer task)
            do (sento.wheel-timer:cancel
                (sento.actor-system:scheduler (schedule-system schedule))
                (task-timer task))
               (setf (slot-value task 'sento-cron/task::timer)
                     nil)
               (let ((queue-size-before (actor-queue-size (task-actor task))))
                 (sento.actor-cell:stop (task-actor task))
                 (let ((queue-size-after (actor-queue-size (task-actor task))))
                   (log:warn "STOP on actor was called"
                             queue-size-before
                             queue-size-after))))
    
    (unless (external-system-p schedule)
      (sento.actor-context:shutdown (schedule-system schedule)
                                    :wait wait))
    
    (setf (slot-value schedule 'running)
          nil)
    (setf (slot-value schedule 'system)
          nil)
    (setf (slot-value schedule 'external-system-p)
          nil)
    
    (loop for task in (schedule-tasks schedule)
          do (setf (slot-value task 'sento-cron/task::actor)
                   nil))
    (values)))


(defun run-scheduled-func (msg)
  (declare (ignore msg))
  (let ((func (getf sento.actor:*state* :func))
        (*print-readably* nil))
    (log:debug "Running ~A" func)
    (setf (getf sento.actor:*state* :processing) t)
    (setf (getf sento.actor:*state* :last-run-started-at)
          (local-time:now))
  
    (funcall func)
  
    (setf (getf sento.actor:*state* :processing) nil)
    (setf (getf sento.actor:*state* :last-run-ended-at)
          (local-time:now))
    (values)))


(defun start-scheduler (schedule &key actor-system)
  (stop-scheduler schedule)
  
  (let ((system (or actor-system
                    (make-actor-system '(:scheduler (:enabled :true))))))
    (unless (sento.actor-system:scheduler system)
      (error "Sento-cron can work only with actor system where scheduler was enabled. Use a form like this to create such scheduler: (make-actor-system '(:scheduler (:enabled :true)))"))
    
    (setf (slot-value schedule 'system)
          system)
    (when actor-system
      (setf (slot-value schedule 'external-system-p)
            t))
    
    (flet ((make-trigger-for (actor task delay)
             (flet ((trigger-func-execution ()
                      (handler-case
                          (with-log-unhandled ()
                            (let ((func (task-func task)))
                              (log:debug "Scheduling ~A execution" func)
                              (handler-case
                                  (sento.actor:tell actor "")
                                (sento.queue:queue-full-error ()
                                  (log:debug "Execution is already scheduled")))))
                        (serious-condition (err)
                          (log:error "Ignoring error to prevent timer breakage" err)))))
               (setf (slot-value task 'sento-cron/task::actor)
                     actor)

               ;; This way we'll trigger a func which will
               ;; put a new message into the actor's queue
               (setf (slot-value task 'sento-cron/task::timer)
                     (sento.wheel-timer:schedule-recurring
                      (sento.actor-system:scheduler system)
                      1     ;; start immediately
                      delay ;; then after a given amount of seconds
                      #'trigger-func-execution)))))
      
      (loop for task in (schedule-tasks schedule)
            for func = (task-func task)
            for actor = (actor-of system
                                  ;; A main work will be done by this actor
                                  :receive #'run-scheduled-func
                                  :name (symbol-name func)
                                  :queue-size 1
                                  ;; Because of this paralllelism issue
                                  ;; https://github.com/mdbergmann/cl-gserver/issues/104
                                  ;; we need dedicated threads for each cron actor
                                  :dispatcher :pinned
                                  :state (list :func func
                                               :processing nil
                                               :last-run-started-at nil
                                               :last-run-ended-at nil))
            for delay = (task-delay task)
            do (make-trigger-for actor task delay))))
  (setf (slot-value schedule 'running)
        t)
  (values))


(defmacro defschedule (var-name &body body)
  (alexandria:with-gensyms (was-running external-system)
    `(eval-always
       (defvar ,var-name)
       
       (let ((,was-running nil)
             (,external-system nil))
         (cond
           ((and (boundp ',var-name)
                 (scheduler-is-running ,var-name))
            (setf ,external-system
                  (when (external-system-p ,var-name)
                    (schedule-system ,var-name)))
            (stop-scheduler ,var-name)
            
            (log:warn "Remembering that cron was running")
            (setf ,was-running
                  t))
           (t
            (log:warn "Cron is not running and will not be restarted")))
         
         (setf ,var-name
               (make-schedule ',body))
         
         (cond
           (,was-running
            (log:warn "Cron was running before defschedule evaluation, restarting it")
            (start-scheduler ,var-name
                             :actor-system ,external-system))
           (t
            (log:warn "Cron was not running before defschedule evaluation, not restarting it")))
         
         (values ,var-name)))))


(-> status (schedule)
    (values &optional))

(defun status (schedule)
  (let ((system (schedule-system schedule)))
    (cond
      (system
       (loop for actor in (sento.actor-context:all-actors system)
             for name = (sento.actor-cell:name actor)
             for state = (sento.actor-cell:state actor)
             do (if (getf state :last-run-started-at)
                    (if (getf state :processing)
                        (format t "~A: in-progress, started-at: ~A, duration: ~A~%"
                                name
                                (getf state :last-run-started-at)
                                (humanize-duration
                                 (timestamp-difference (now)
                                                       (getf state :last-run-started-at))))
                        (format t "~A: last-run-started-at: ~A, duration: ~A~%"
                                name
                                (getf state :last-run-started-at)
                                (humanize-duration
                                 (timestamp-difference (getf state :last-run-ended-at)
                                                       (getf state :last-run-started-at)))))
                    (format t "~A: never run"
                            name))))
      (t
       (format t "Not running~%")))
    (values)))

