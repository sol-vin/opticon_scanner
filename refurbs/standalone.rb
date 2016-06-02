
require_relative '../lib/opticon_refurbisher'

OpticonRefurbs.add :standalone do
  run :usb_enabled
  run :enable_memory
  run :always_memorize_batch
  run :send_primary_message_only
  run :enable_reconnect_bt_after_scan
  run :enable_retention_after_send
  run :send_when_function_press
  run :save_settings
end