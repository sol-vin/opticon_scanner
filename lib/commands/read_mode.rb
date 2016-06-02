require_relative '../command'

# These commands can be found on page U113 in the UMH

class SingleRead < Command
  set_begin_bytes 'S0'
  set_tag :single_read
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.refresh_settings
  end
end

class MultipleRead < Command
  set_begin_bytes 'S1'
  set_tag :multiple_read
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.refresh_settings
  end
end

class ContinuousRead < Command
  set_begin_bytes 'S2'
  set_tag :continuous_read
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.refresh_settings
  end
end

class DisableTrigger < Command
  set_begin_bytes 'S7'
  set_tag :disable_trigger
  set_status :working
end

class EnableTrigger < Command
  set_begin_bytes 'S8'
  set_tag :enable_trigger
  set_status :working
end

class WaitModeDisabled < Command
  set_begin_bytes 'XA'
  set_tag :wait_mode_disabled
end

class WaitMode250ms < Command
  set_begin_bytes 'XB'
  set_tag :wait_mode_250ms
end

class WaitMode500ms < Command
  set_begin_bytes 'XC'
  set_tag :wait_mode_500ms
end

class WaitMode750ms < Command
  set_begin_bytes 'XD'
  set_tag :wait_mode_750ms
end

class DisableTriggerRepeat < Command
  set_begin_bytes '/K'
  set_tag :disable_trigger_repeat
  set_status :working
end

class EnableTriggerRepeat < Command
  set_begin_bytes '/M'
  set_tag :enable_trigger_repeat
  set_status :working
end

class StructuredAppendTimeout < Command
  set_begin_bytes '[BE2'
  set_tag :structured_append_timeout
end


# These commands can be found on page U114

class MultipleReadReset50ms < Command
  set_begin_bytes 'AH'
  set_tag :multiple_read_reset_50ms
end

class MultipleReadReset100ms < Command
  set_begin_bytes 'AI'
  set_tag :multiple_read_reset_1000ms
end

class MultipleReadReset200ms < Command
  set_begin_bytes 'AJ'
  set_tag :multiple_read_reset_200ms
end

class MultipleReadReset300ms < Command
  set_begin_bytes 'AK'
  set_tag :multiple_read_reset_300ms
end

class MultipleReadReset400ms < Command
  set_begin_bytes 'AL'
  set_tag :multiple_read_reset_400ms
end

class MultipleReadReset500ms < Command
  set_begin_bytes 'AM'
  set_tag :multiple_read_reset_500ms
end

class MultipleReadReset600ms < Command
  set_begin_bytes 'AN'
  set_tag :multiple_read_reset_600ms
end

class MultipleReadResetInfinite < Command
  set_begin_bytes 'AG'
  set_tag :multiple_read_reset_infinite
end

# These commands can be found on page U117 in the UMH

class ReadTime0s < Command
  set_begin_bytes 'Y0'
  set_tag :read_time_0s
  set_status :working
end

class ReadTim1s < Command
  set_begin_bytes 'Y1'
  set_tag :read_time_1s
  set_status :working
end

class ReadTime2s < Command
  set_begin_bytes 'Y2'
  set_tag :read_time_2s
  set_status :working
end

class ReadTime3s < Command
  set_begin_bytes 'Y3'
  set_tag :read_time_3s
  set_status :working
end

class ReadTime4s < Command
  set_begin_bytes 'Y4'
  set_tag :read_time_4s
  set_status :working
end

class ReadTime5s < Command
  set_begin_bytes 'Y5'
  set_tag :read_time_5s
  set_status :working
end

class ReadTime6s < Command
  set_begin_bytes 'Y6'
  set_tag :read_time_6s
  set_status :working
end

class ReadTime7s < Command
  set_begin_bytes 'Y7'
  set_tag :read_time_7s
  set_status :working
end

class ReadTime8s < Command
  set_begin_bytes 'Y8'
  set_tag :read_time_8s
  set_status :working
end

class ReadTime9s < Command
  set_begin_bytes 'Y9'
  set_tag :read_time_9s
  set_status :working
end

class ReadTimeTimes10 < Command
  set_begin_bytes 'YL'
  set_tag :read_time_times_10
  set_status :working
end

class ReadTimeInfinite < Command
  set_begin_bytes 'YM'
  set_tag :read_time_7s
end

# These commands can be found on page U120 of the UMH

class ReadPositiveCodes < Command
  set_begin_bytes 'V2'
  set_tag :read_positive_codes
end

class ReadNegativeCodes < Command
  set_begin_bytes 'V3'
  set_tag :read_negative_codes
end

class ReadPositiveNegativeCodes < Command
  set_begin_bytes 'V4'
  set_tag :read_positive_negative_codes
end

# These commands are combo commands

class EnablePresentationMode < Command
  set_begin_bytes ContinuousRead.begin_bytes
  set_end_bytes DisableTrigger.begin_bytes

  set_tag :enable_presentation_mode
end

class DisablePresentationMode < Command
  set_begin_bytes SingleRead.begin_bytes
  set_end_bytes EnableTrigger.begin_bytes

  set_tag :disable_presentation_mode
end