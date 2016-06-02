require_relative '../lib/opticon_refurbisher'

OpticonRefurbs.add :regex do
  run :set_cut_script, "(?:<\\^>\"\\x0D\"|.)+$"
  run :set_paste_script, "[0]\\x0D"
  run :store_regex, 1
  run :enable_regex, 1
end