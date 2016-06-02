# Opticon Ruby
```ruby
require 'opticon_scanner'
opticon = Opticon.new '/dev/ttyUSB0' #COM0 on windows
puts opticon.run :get_settings
10.times { opticon.run :good_beep }
3.times { opticon.run :error_beep }
opticon.run :trigger

opticon.run :enable_presentation_mode

#Finding scanners

Opticon.search
opticon.each do |scanner|
  scanner.run_batch do
    run :clear_memory
    run :set_time, Time.now
    run :enable_presentation_mode
  end
end
```
