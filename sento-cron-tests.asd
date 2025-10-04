(defsystem "sento-cron-tests"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/sento-cron/"
  :class :package-inferred-system
  :description "Provides tests for sento-cron."
  :source-control (:git "https://github.com/40ants/sento-cron")
  :bug-tracker "https://github.com/40ants/sento-cron/issues"
  :pathname "t"
  :depends-on ("sento-cron-tests/core")
  :perform (test-op (op c)
                    (unless (symbol-call :rove :run c)
                      (error "Tests failed"))))


(asdf:register-system-packages "sento" '("SENTO.ACTOR-SYSTEM"
                                         "SENTO.ACTOR-CONTEXT"
                                         "SENTO.ACTOR-CELL"
                                         "SENTO.ACTOR"
                                         "SENTO.WHEEL-TIMER"
                                         "SENTO.QUEUE"))
