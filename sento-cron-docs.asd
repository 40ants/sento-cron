(defsystem "sento-cron-docs"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/sento-cron/"
  :class :package-inferred-system
  :description "Provides documentation for sento-cron."
  :source-control (:git "https://github.com/40ants/sento-cron")
  :bug-tracker "https://github.com/40ants/sento-cron/issues"
  :pathname "docs"
  :depends-on ("sento-cron"
               "sento-cron-docs/index"))
