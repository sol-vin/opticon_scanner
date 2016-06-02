require_relative './direct_input'
require_relative '../command'

# These commands can be found on page U22 in the UMH

class SetBluetoothAddressStart < Command
  set_begin_bytes ']BDAS'
  set_tag :set_bluetooth_address_start
  set_status :working
end

class SetBluetoothAddressEnd < Command
  set_begin_bytes ']BDAE'
  set_tag :set_bluetooth_address_end
  set_status :working
end

class SetBluetoothAddress < Command
  set_begin_bytes SetBluetoothAddressStart.begin_bytes
  set_end_bytes SetBluetoothAddressEnd.begin_bytes
  set_tag :set_bluetooth_address
  set_status :working

  def self.make_data(*args)
    fail ArgumentError unless args.first.length == 12
    args.first.each_char.map { |c| DirectInput.convert_to c.upcase}
  end

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.refresh_settings
  end
end

class EnableAutoConnect < Command
  set_begin_bytes ']ENAU'
  set_tag :enable_auto_connect
end

class DisableAutoConnect < Command
  set_begin_bytes ']DIAU'
  set_tag :disable_auto_connect
end

class ConnectToPC < Command
  set_begin_bytes ']CNPC'
  set_tag :connect_to_pc
end

class ConnectToCradle < Command
  set_begin_bytes ']CNCR'
  set_tag :connect_to_cradle
end

class ConnectToCradleHID < Command
  set_begin_bytes ']CNC2'
  set_tag :connect_to_cradle_hid
end

class BluetoothConnect < Command
  set_begin_bytes '+-CONN-+'
  set_tag :bluetooth_connect
  set_status :broken
end

class BluetoothDisconnect < Command
  set_begin_bytes '+-DISC-+'
  set_tag :bluetooth_disconnect
end

class BluetoothDiscoverable < Command
  set_begin_bytes '+-DSCO-+'
  set_tag :bluetooth_discoverable
end

# These commands can be found on page U23 in the UMH

class SetPinCodeStart < Command
  set_begin_bytes ']PINS'
  set_tag :set_pin_code_start

  set_status :working
end

class SetPinCodeEnd < Command
  set_begin_bytes ']PINE'
  set_tag :set_pin_code_end

  set_status :working
end

class SetPinCode < Command
  set_begin_bytes SetPinCodeStart.begin_bytes
  set_end_bytes SetPinCodeEnd.begin_bytes

  set_tag :set_pin_code
  set_status :working

  def self.make_data(*args)
    fail ArgumentError.new if args.first.length > 16
    args.first.each_char.map { |c| DirectInput.convert_to c}
  end

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.refresh_settings
  end
end

class AuthenticateUnpaired < Command
  set_begin_bytes ']AUTO'
  set_tag :authenticate_unpaired
end

class DisableAuthentication < Command
  set_begin_bytes ']AUTD'
  set_tag :disable_authentication
end

class EnableAuthentication < Command
  set_begin_bytes ']AUTE'
  set_tag :enable_authentication
end

class DisableEncryption < Command
  set_begin_bytes ']ENCD'
  set_tag :disable_encryption
end

class EnableEncryption < Command
  set_begin_bytes ']ENCE'
  set_tag :enable_encryption
end

# These commands can be found on page U24 in the UMH


class TriggerConnectDisabled < Command
  set_begin_bytes ']PC00'
  set_tag :trigger_connect_disabled
end

class TriggerConnect1 < Command
  set_begin_bytes ']PC01'
  set_tag :trigger_connect1
end

class TriggerConnect2 < Command
  set_begin_bytes ']PC02'
  set_tag :trigger_connect2
end

class TriggerConnect3 < Command
  set_begin_bytes ']PC03'
  set_tag :trigger_connect3
end

class TriggerConnect4 < Command
  set_begin_bytes ']PC04'
  set_tag :trigger_connect4
end

class TriggerConnect5 < Command
  set_begin_bytes ']PC05'
  set_tag :trigger_connect5
end

class TriggerConnect6 < Command
  set_begin_bytes ']PC06'
  set_tag :trigger_connect6
end

class TriggerConnect7 < Command
  set_begin_bytes ']PC07'
  set_tag :trigger_connect7
end

class TriggerConnect8 < Command
  set_begin_bytes ']PC08'
  set_tag :trigger_connect8
end

class TriggerConnect9 < Command
  set_begin_bytes ']PC09'
  set_tag :trigger_connect9
end

# These commands can be found on page U25 in the UMH

class TriggerConnect < Command
  set_begin_bytes '[BBC'
  set_tag :trigger_connect
end

class TriggerConnectDiscoverable < Command
  set_begin_bytes '[BBD'
  set_tag :trigger_connect_discoverable
end

# These commands can be found on page U26 in the UMH


class TriggerDisconnectDisabled < Command
  set_begin_bytes ']PD00'
  set_tag :trigger_disconnect_disabled
end

class TriggerDisconnect1 < Command
  set_begin_bytes ']PD01'
  set_tag :trigger_disconnect1
end

class TriggerDisconnect2 < Command
  set_begin_bytes ']PD02'
  set_tag :trigger_disconnect2
end

class TriggerDisconnect3 < Command
  set_begin_bytes ']PD03'
  set_tag :trigger_disconnect3
end

class TriggerDisconnect4 < Command
  set_begin_bytes ']PD04'
  set_tag :trigger_disconnect4
end

class TriggerDisconnect5 < Command
  set_begin_bytes ']PD05'
  set_tag :trigger_disconnect5
end

class TriggerDisconnect6 < Command
  set_begin_bytes ']PD06'
  set_tag :trigger_disconnect6
end

class TriggerDisconnect7 < Command
  set_begin_bytes ']PD07'
  set_tag :trigger_disconnect7
end

class TriggerDisconnect8 < Command
  set_begin_bytes ']PD08'
  set_tag :trigger_disconnect8
end

class TriggerDisconnect9 < Command
  set_begin_bytes ']PD09'
  set_tag :trigger_disconnect9
end

# These commands can be found on page U27 in the UMH

class AutoDisconnectDisabled < Command
  set_begin_bytes ']AD00'
  set_tag :auto_disconnect_disabled
end

class AutoDisconnect10 < Command
  set_begin_bytes ']AD01'
  set_tag :auto_disconnect10
end

class AutoDisconnect20 < Command
  set_begin_bytes ']AD02'
  set_tag :auto_disconnect20
end

class AutoDisconnect30 < Command
  set_begin_bytes ']AD03'
  set_tag :auto_disconnect30
end

class AutoDisconnect40 < Command
  set_begin_bytes ']AD04'
  set_tag :auto_disconnect40s
end

class AutoDisconnect50 < Command
  set_begin_bytes ']AD05'
  set_tag :auto_disconnect50
end

class AutoDisconnect60 < Command
  set_begin_bytes ']AD06'
  set_tag :auto_disconnect60
end

# These commands can be found on page U28 in the UMH

class AutoReconnectDisabled < Command
  set_begin_bytes ']CA00'
  set_tag :auto_reconnect_disabled
end


class AutoReconnect1 < Command
  set_begin_bytes ']CA01'
  set_tag :auto_reconnect_1m
end

class AutoReconnect2 < Command
  set_begin_bytes ']CA02'
  set_tag :auto_reconnect_2m
end

class AutoReconnect3 < Command
  set_begin_bytes ']CA03'
  set_tag :auto_reconnect_3m
end

class AutoReconnect4 < Command
  set_begin_bytes ']CA04'
  set_tag :auto_reconnect_4m
end

class AutoReconnect5 < Command
  set_begin_bytes ']CA05'
  set_tag :auto_reconnect_5m
end

class AutoReconnect6 < Command
  set_begin_bytes ']CA06'
  set_tag :auto_reconnect_6m
end

class AutoReconnect7 < Command
  set_begin_bytes ']CA07'
  set_tag :auto_reconnect_7m
end

class AutoReconnect8 < Command
  set_begin_bytes ']CA08'
  set_tag :auto_reconnect_8m
end

class AutoReconnect9 < Command
  set_begin_bytes ']CA09'
  set_tag :auto_reconnect_9m
end

# These commands can be found on page U29 in the UMH

class PowerSaveLevel0 < Command
  set_begin_bytes ']LV00'
  set_tag :power_save_level0
end

class PowerSaveLevel1 < Command
  set_begin_bytes ']LV01'
  set_tag :power_save_level1
end

class PowerSaveLevel2 < Command
  set_begin_bytes ']LV02'
  set_tag :power_save_level2
end

class PowerSaveLevel3 < Command
  set_begin_bytes ']LV03'
  set_tag :power_save_level3
end

class PowerSaveLevel4 < Command
  set_begin_bytes ']LV04'
  set_tag :power_save_level4
end

class PowerSaveLeve5 < Command
  set_begin_bytes ']LV05'
  set_tag :power_save_level5
end

class PowerSaveLevel6 < Command
  set_begin_bytes ']LV06'
  set_tag :power_save_level6
end

class PowerSaveLevel7 < Command
  set_begin_bytes ']LV07'
  set_tag :power_save_level7
end

# These commands can be found on page 11 of the OPN-3002i handbook

class SetBluetoothNameStart < Command
  set_begin_bytes '[E65'
  set_tag :set_bluetooth_name_start
  set_status :working
end

class SetBluetoothNameEnd < Command
  set_begin_bytes '[E66'
  set_tag :set_bluetooth_name_end
  set_status :working
end

class SetBluetoothName < Command
  set_begin_bytes SetBluetoothNameStart.begin_bytes
  set_end_bytes SetBluetoothNameEnd.begin_bytes

  set_tag :set_bluetooth_name
  set_status :working

  def self.make_data(*args)
    args.first.each_char.map { |c| DirectInput.convert_to c.upcase}
  end

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.refresh_settings
  end
end

# These commands were found on the Optoconfigure site

class BluetoothSearch < Command
  set_begin_bytes '+-SRCH-+'
  set_tag :bluetooth_search
end

class BluetoothRegister < Command
  set_begin_bytes '+-RGST-+'
  set_tag :bluetooth_register
end

class BluetoothUnpair < Command
  set_begin_bytes '+-UNPR-+'
  set_tag :bluetooth_unpair
end


# These commands were referenced in an email to SerialIO

class EnableReconnectBTAfterScan < Command
  set_begin_bytes '[BRE'
  set_tag :enable_reconnect_bt_after_scan
end

class DisableReconnectBTAfterScan < Command
  set_begin_bytes '[BRD'
  set_tag :disable_reconnect_bt_after_scan
end