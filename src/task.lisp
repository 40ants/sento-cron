(uiop:define-package #:sento-cron/task
  (:use #:cl)
  (:import-from #:alexandria
                #:positive-integer)
  (:export #:task
           #:task-delay
           #:task-func
           #:task-timer
           #:task-actor))
(in-package #:sento-cron/task)


(defclass task ()
  ((delay :initarg :delay
          :type positive-integer
          :reader task-delay)
   (func :initarg :func
         :type symbol
         :reader task-func)
   (timer :initform nil
          :type (or null symbol)
          :reader task-timer)
   (actor :initform nil
          :reader task-actor)))


(defmethod print-object ((task task) stream)
  (print-unreadable-object (task stream :type t)
    (format stream "~S delay=~A"
            (task-func task)
            (task-delay task))))
