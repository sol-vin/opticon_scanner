require_relative '../command'

#These commands can be found on page U3 of the Universal Menu Handbook

class BadReadLedOn < Command
  set_begin_bytes ?N
  set_tag :bad_read_led_on
  set_status :working
end

class BothLedsOn < Command
  set_begin_bytes ?O
  set_tag :both_leds_on
  set_status :working
end

class ErrorBeep < Command
  set_begin_bytes ?E
  set_tag :error_beep
  set_status :working
end

class GoodBeep < Command
  set_begin_bytes ?B
  set_tag :good_beep
  set_status :working
end

class GoodReadLedOn < Command
  set_begin_bytes ?L
  set_tag :good_read_led_on
  set_status :working
end

class MotorOff < Command
  set_begin_bytes ?G
  set_tag :motor_off
end

class MotorOn < Command
  set_begin_bytes ?H
  set_tag :motor_on
end

class Trigger < Command
  set_begin_bytes ?Z
  set_tag :trigger
  set_status :working
end

class Detrigger < Command
  set_begin_bytes ?Y
  set_tag :detrigger
  set_status :working
end

class DisableLaser < Command
  set_begin_bytes ?P
  set_tag :disable_laser
end

class EnableLaser < Command
  set_begin_bytes ?Q
  set_tag :enable_laser
end

# These commnands can be found on page U121 in the UMH

class DisableFloodlight < Command
  set_begin_bytes '[D3A'
  set_tag :disable_floodlight
end

class EnableFloodlight < Command
  set_begin_bytes '[D39'
  set_tag :enable_floodlight
end

class AlternatingFloodlight < Command
  set_begin_bytes '[D3B'
  set_tag :alternating_floodlight
end

# These commands can be found on page U124 in the UMH

class DisableBuzzer < Command
  set_begin_bytes 'W0'
  set_tag :disable_buzzer
  set_status :working
end

class EnableBuzzer < Command
  set_begin_bytes 'W8'
  set_tag :enable_buzzer
  set_status :working
end

class SingleToneBuzzer < Command
  set_begin_bytes 'W1'
  set_tag :single_tone_buzzer
  set_status :working
end

class HighLowBuzzer < Command
  set_begin_bytes 'W2'
  set_tag :high_low_buzzer
  set_status :working
end

# These commands can be found on page U125 in the UMH

class LowHighBuzzer < Command
  set_begin_bytes 'W3'
  set_tag :low_high_buzzer
  set_status :working
end

class BuzzerDuration50ms < Command
  set_begin_bytes 'W7'
  set_tag :buzzer_duration_50ms
  set_status :working
end

class BuzzerDuration100ms < Command
  set_begin_bytes 'W4'
  set_tag :buzzer_duration_100ms
  set_status :working
end

class BuzzerDuration200ms < Command
  set_begin_bytes 'W5'
  set_tag :buzzer_duration_200ms
  set_status :working
end

class BuzzerDuration400ms < Command
  set_begin_bytes 'W6'
  set_tag :buzzer_duration_400ms
  set_status :working
end

class BuzzerVolumeMax < Command
  set_begin_bytes 'T0'
  set_tag :buzzer_volume_max
  set_status :working
end

class BuzzerVolumeLoud < Command
  set_begin_bytes 'T1'
  set_tag :buzzer_volume_loud
  set_status :working
end

class BuzzerVolumeNormal < Command
  set_begin_bytes 'T2'
  set_tag :buzzer_volume_normal
  set_status :working
end

class BuzzerVolumeMin < Command
  set_begin_bytes 'T3'
  set_tag :buzzer_volume_min
  set_status :working
end

class BuzzerBeforeSend < Command
  set_begin_bytes 'VY'
  set_tag :buzzer_before_send
  set_status :working
end

class BuzzerAfterSend < Command
  set_begin_bytes 'VZ'
  set_tag :buzzer_after_send
  set_status :working
end

class DisableStartupBuzzer < Command
  set_begin_bytes 'GD'
  set_tag :disable_startup_buzzer
  set_status :working
end

class EnableStartupBuzzer < Command
  set_begin_bytes 'GC'
  set_tag :enable_startup_buzzer
  set_status :working
end

# These commands can be found on page U126 in the UMH

class DisableGoodReadLed < Command
  set_begin_bytes 'T4'
  set_tag :disable_good_read_led
end

class EnableGoodReadLed200ms < Command
  set_begin_bytes 'T5'
  set_tag :enable_good_read_led_200ms
end

class EnableGoodReadLed400ms < Command
  set_begin_bytes 'T6'
  set_tag :enable_good_read_led_400ms
end

class EnableGoodReadLed800ms < Command
  set_begin_bytes 'T7'
  set_tag :enable_good_read_led_800ms
end

# These commands can be found on page U118 in the UMH

class DisableMotorWhenIdle < Command
  set_begin_bytes '4Z'
  set_tag :disable_motor_when_idle
end

class EnableMotorWhenIdle < Command
  set_begin_bytes '4Y'
  set_tag :disable_motor_when_idle
end

class MotorHalfSpeedMotorWhenIdle < Command
  set_begin_bytes '[BBA'
  set_tag :motor_half_speed_when_idle
end




