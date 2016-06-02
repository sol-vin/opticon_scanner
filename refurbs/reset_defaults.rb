require_relative '../lib/opticon_refurbisher'

OpticonRefurbs.add :reset_defaults do
  run :reset_defaults
  # causes a disconnect
  # scanner should wait before proceeding
  # tech needs to scan USB code before 30 secs.
  3.times {run :good_beep}
end