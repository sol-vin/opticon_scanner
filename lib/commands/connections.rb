require_relative './direct_input'
require_relative '../command'

#These commands can be found on page U4 of the Universal Menu Handbook

class RS232 < Command
  set_begin_bytes 'U2'
  set_tag :rs232
end

class IEEEVCP < Command
  set_begin_bytes 'SM'
  set_tag :ieee_vcp
end

class BluetoothSPP < Command
  set_begin_bytes 'SO'
  set_tag :bluetooth_spp
  causes_disconnect true
end

class ATWedge < Command
  set_begin_bytes 'UB'
  set_tag :at_wedge
end

class BluetoothHID < Command
  set_begin_bytes '[C02'
  set_tag :bluetooth_hid
end

class SerialTTL < Command
  set_begin_bytes 'SS'
  set_tag :serial_ttl
end

class USBHID < Command
  set_begin_bytes 'SU'
  set_tag :usb_hid
end

class USBVCP < Command
  set_begin_bytes '[C01'
  set_tag :usb_vcp
  set_status :working
end

# This command can be found on page 9 in the OPN-3002i handbook
class BlueSnapMasterMode < Command
  set_begin_bytes ']BCMA'
  set_tag :bluesnap_master_mode
end

# This command can be found on page 9 in the OPN-3002i handbook
class BlueSnapSlaveMode < Command
  set_begin_bytes ']BCSA'
  set_tag :bluesnap_slave_mode
end

# This command can be found on page 11 in the OPN-3002i handbook
class USBEnabled < Command
  set_begin_bytes '[C11'
  set_tag :usb_enabled
  set_status :working
end

# This command can be found on page 10 in the OPN-3002i handbook
class USBDisabled < Command
  set_begin_bytes '[C10'
  set_tag :usb_disabled
  set_status :working
  causes_disconnect true
end

# This command is only mentioned on the SerialIO sheet
class MiFiMode < Command
  set_begin_bytes ']BCSI'
  set_tag :mifi_mode
end

#Found on opticonfigure
class BluetoothLE < Command
  set_begin_bytes ']BTLE'
  set_tag :bluetooth_le
end
