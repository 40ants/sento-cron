(uiop:define-package #:sento-cron/utils
  (:use #:cl)
  (:import-from #:bordeaux-threads))
(in-package #:sento-cron/utils)


(defun %destroy-sento-threads ()
  (loop for thread in (bt2:all-threads)
        when (or (str:starts-with? "message-" (bt2:thread-name thread))
                 (str:starts-with? "timer-" (bt2:thread-name thread)))
          do (bt2:destroy-thread thread)
          and count 1))



(defun show-actors-info (&key verbose)
  (cl-telegram-bot2/debug::actors-info 
   (schedule-system *schedule*)
   :verbose verbose))
