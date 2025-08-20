(uiop:define-package #:sento-cron-tests/core
  (:use #:cl)
  (:import-from #:rove
                #:deftest
                #:ok
                #:testing)
  (:import-from #:log4cl-extras/error
                #:with-log-unhandled))
(in-package #:sento-cron-tests/core)


(defvar *run-num* 0)


(defun test-func ()
  (with-log-unhandled ()
    (let ((run-num (incf *run-num*))
          (num-seconds 120))
      (log:info "Sleeping" run-num num-seconds)
      (sleep num-seconds)
      (log:info "Sleeping Done" run-num))))



(defschedule *schedule*
  (5 test-func))


(defun test-stopping (&key (wait t))
  (let* ((system (make-actor-system))
         (actor (flet ((func (msg)
                         (log:warn "Sleeping 10 seconds" msg)
                         (sleep 10)
                         (log:warn "Done")))
                  (actor-of system
                            :receive #'func
                            ;; :other-args '(:queue-size 1)
                            ))))
    (log:warn "Posting messages to the actor")
    (sento.actor:tell actor "first-time")
    (sento.actor:tell actor "second-time")
    (sento.actor-cell:stop actor)
    (log:warn "Stopping the system")
    (sento.actor-context:shutdown system
                                  :wait wait)
    (log:warn "System was stopped")
    (values)))


(defun test-recurring-timers ()
  (flet ((func1 ()
           (log:info "Func 1 was called"))
         (func2 ()
           (log:info "Func 2 was called")))
    (let* ((system (make-actor-system '(:scheduler (:enabled :true)))))
      (unwind-protect
           (progn
             (let* ((scheduler (sento.actor-system:scheduler system))
                    (timer1 (sento.wheel-timer:schedule-recurring
                             scheduler
                             1 ;; start immediately
                             5 ;; then every 5 seconds
                             #'func1))
                    (timer2 (sento.wheel-timer:schedule-recurring
                             scheduler
                             1  ;; start immediately
                             10 ;; then every 5 seconds
                             #'func2)))
               (log:info "Timers were created:" timer1 timer2)

               (sleep 60)))
        (sento.actor-context:shutdown system
                                      :wait t))))
  (values))


(deftest test-example ()
  (ok t "Replace this test with something useful."))


