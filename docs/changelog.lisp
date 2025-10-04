(uiop:define-package #:sento-cron-docs/changelog
  (:use #:cl)
  (:import-from #:40ants-doc/changelog
                #:defchangelog))
(in-package #:sento-cron-docs/changelog)


(defchangelog (:ignore-words ("SLY"
                              "ASDF"
                              "REPL"
                              "HTTP"))
  (0.1.1 2025-10-05
         "* Fixed cron actor initialization on evaluation of defschedule in case if cron was started using an external actors system.")
  (0.1.0 2025-08-20
         "* Initial version."))
