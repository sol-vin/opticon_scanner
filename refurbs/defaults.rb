require_relative '../lib/opticon_refurbisher'

OpticonRefurbs.add :defaults do
  run :rs232_delay_none
  run :key_lang_us
  run :enable_auto_connect
  run :auto_disconnect_disabled
  run :auto_reconnect_5m
  run :power_save_level0
  run :enable_memory
  run :always_memorize_batch
  run :blank_preamble
  run :blank_postamble
  run :clear_prefix
  run :clear_suffix
  run :blank_sio_prefix
  run :set_suffix, "\r"
  run :enable_all_codes
  run :single_read
  run :enable_trigger
  run :disable_trigger_repeat
  run :read_time_2s
  run :read_positive_codes
  run :enable_floodlight
  run :enable_buzzer
  run :disable_startup_buzzer
  run :single_tone_buzzer
  run :buzzer_duration_200ms
  run :buzzer_before_send
  run :buzzer_volume_max
  run :enable_good_read_led_200ms
  run :enable_rs232_configuration
  run :enable_rs232_trigger
  run :enable_rs232_buzzer
  run :enable_rs232_good_read_led
  run :disable_rs232_ack_nak
  run :enable_toggle_laser
  run :send_when_function_press
  run :save_settings

  run :set_time, Time.now.localtime("-07:00")
end