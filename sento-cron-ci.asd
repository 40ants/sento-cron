(defsystem "sento-cron-ci"
  :author "Alexander Artemenko <svetlyak.40wt@gmail.com>"
  :license "Unlicense"
  :homepage "https://40ants.com/sento-cron/"
  :class :package-inferred-system
  :description "Provides CI settings for sento-cron."
  :source-control (:git "https://github.com/40ants/sento-cron")
  :bug-tracker "https://github.com/40ants/sento-cron/issues"
  :pathname "src"
  :depends-on ("40ants-ci"
               "sento-cron-ci/ci"))
