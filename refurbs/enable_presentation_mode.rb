
require_relative '../lib/opticon_refurbisher'

OpticonRefurbs.add :enable_presentation_mode do
  run :continuous_read
  run :disable_trigger
end