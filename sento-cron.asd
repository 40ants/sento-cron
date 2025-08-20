#-asdf3.1 (error "sento-cron requires ASDF 3.1 because for lower versions pathname does not work for package-inferred systems.")
(defsystem "sento-cron"
  :description "A library for scheduling periodic tasks using Sento actors framework."
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/sento-cron/"
  :source-control (:git "https://github.com/40ants/sento-cron")
  :bug-tracker "https://github.com/40ants/sento-cron/issues"
  :class :40ants-asdf-system
  :defsystem-depends-on ("40ants-asdf-system")
  :pathname "src"
  :depends-on ("sento-cron/core"
               "sento-cron/schedule")
  :in-order-to ((test-op (test-op "sento-cron-tests"))))
