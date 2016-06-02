
require_relative '../lib/opticon_refurbisher'

OpticonRefurbs.add :disable_presentation_mode do
  run :single_read
  run :enable_trigger
end