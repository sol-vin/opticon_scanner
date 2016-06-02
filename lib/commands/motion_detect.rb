require_relative '../command'

# These commands can be found on page U116 in the UMH

class DisableAutoTrigger < Command
  set_begin_bytes '+F'
  set_tag :disable_auto_trigger
  set_status :working
end

class EnableAutoTrigger < Command
  set_begin_bytes '+I'
  set_tag :enable_auto_trigger
  set_status :working
end

class EnableStandDetection < Command
  set_begin_bytes '*4'
  set_tag :enable_stand_detection
end