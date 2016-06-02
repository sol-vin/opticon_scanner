require_relative '../command'

# This command can be found on page U9 in the UMH

class Baud150 < Command
  set_begin_bytes 'K0'
  set_tag :baud_150
end

class Baud300 < Command
  set_begin_bytes 'K1'
  set_tag :baud_300
end

class Baud600 < Command
  set_begin_bytes 'K2'
  set_tag :baud_600
end

class Baud1200 < Command
  set_begin_bytes 'K3'
  set_tag :baud_1200
end

class Baud2400 < Command
  set_begin_bytes 'K4'
  set_tag :baud_2400
end

class Baud4800 < Command
  set_begin_bytes 'K5'
  set_tag :baud_4800
end

class Baud9600 < Command
  set_begin_bytes 'K6'
  set_tag :baud_9600
end

class Baud19200 < Command
  set_begin_bytes 'K7'
  set_tag :baud_19200
end

class Baud38400 < Command
  set_begin_bytes 'K8'
  set_tag :baud_38400
end

class Baud57600 < Command
  set_begin_bytes 'K9'
  set_tag :baud_57600
end

class Baud115200 < Command
  set_begin_bytes 'SZ'
  set_tag :baud_114200
end


class SevenDataBits < Command
  set_begin_bytes 'L0'
  set_tag :seven_data_bits
end

class EightDataBits < Command
  set_begin_bytes 'L1'
  set_tag :eight_data_bits
end

class EvenParity < Command
  set_begin_bytes 'L3'
  set_tag :even_parity
end

class OddParity < Command
  set_begin_bytes 'L4'
  set_tag :odd_parity
end

# These commands can be found on page U10 in the UMH

class NoParity < Command
  set_begin_bytes 'L2'
  set_tag :no_parity
end

class OneStopBit < Command
  set_begin_bytes 'L5'
  set_tag :one_stop_bit
end

class TwoStopBits < Command
  set_begin_bytes 'L6'
  set_tag :two_stop_bits
end

# These commands can be found on page U13 in the UMH

class NoHandshake < Command
  set_begin_bytes 'P0'
  set_tag :no_handshake
end

class BusyReady < Command
  set_begin_bytes 'P1'
  set_tag :busy_ready
end

class Modem < Command
  set_begin_bytes 'P2'
  set_tag :modem
end

class AckNak < Command
  set_begin_bytes 'P3'
  set_tag :ack_nak
end

class AckNakNoResponce < Command
  set_begin_bytes 'P4'
  set_tag :ack_nak_no_responce
end

class XonXoff < Command
  set_begin_bytes 'ZG'
  set_tag :xon_xoff
end

class TimeoutInfinite < Command
  set_begin_bytes 'I0'
  set_tag :flow_timeout_infinite
end

class Timeout100ms < Command
  set_begin_bytes 'I1'
  set_tag :flow_timeout_100ms
end

class Timeout200ms < Command
  set_begin_bytes 'I2'
  set_tag :flow_timeout_200ms
end

class Timeout400ms < Command
  set_begin_bytes 'I3'
  set_tag :flow_timeout_400ms
end

# These command can be found on page U14 in the UMH

class RS232DelayNone < Command
  set_begin_bytes 'KA'
  set_tag :rs232_delay_none
end

class RS232Delay20ms < Command
  set_begin_bytes 'KB'
  set_tag :rs232_delay_20ms
end
class RS232Delay50ms < Command
  set_begin_bytes 'KC'
  set_tag :rs232_delay_50ms
end

class RS232Delay100ms < Command
  set_begin_bytes 'KD'
  set_tag :rs232_delay_100ms
end

# These commands can be found on page U129 in the UMH

class DisableRS232Configuration < Command
  set_begin_bytes 'TS'
  set_tag :disable_rs232_configuration
end

class EnableRS232Configuration < Command
  set_begin_bytes 'TT'
  set_tag :enable_rs232_configuration
end

class DisableRS232Trigger < Command
  set_begin_bytes '8B'
  set_tag :disable_rs232_trigger
end

class EnableRS232Trigger < Command
  set_begin_bytes '8C'
  set_tag :enable_rs232_trigger
end

class DisableRS232Buzzer < Command
  set_begin_bytes 'WB'
  set_tag :disable_rs232_buzzer
end

class EnableRS232Buzzer < Command
  set_begin_bytes 'WA'
  set_tag :enable_rs232_buzzer
end

class DisableRS232GoodReadLed < Command
  set_begin_bytes 'TY'
  set_tag :disable_rs232_good_read_led
end

class EnableRS232GoodReadLed < Command
  set_begin_bytes 'TZ'
  set_tag :enable_rs232_good_read_led
end

class DisableRS232ACKNACK < Command
  set_begin_bytes 'WD'
  set_tag :disable_rs232_ack_nak
end

class EnableRS232ACKNACK < Command
  set_begin_bytes 'WC'
  set_tag :enable_rs232_ack_nak
end

class EnableToggleLaser < Command
  set_begin_bytes 'SR'
  set_tag :enable_toggle_laser
end

class DisableToggleLaser < Command
  set_begin_bytes 'SQ'
  set_tag :disable_toggle_laser
end

#?????????? What does this do?

class ClearErrorNoLabelNoDecode < Command
  set_begin_bytes 'TG'
  set_tag :clear_error_no_label_no_decode
end

class ErrorNoLabel < Command
  set_begin_bytes 'TH'
  set_tag :error_no_label
end

class ErrorNoDecode < Command
  set_begin_bytes 'TI'
  set_tag :error_no_decode
end





