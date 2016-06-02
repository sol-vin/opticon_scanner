require_relative '../command'
require_relative './direct_input'

# These commands can be found on page U31 in the UMH

class DisableMemory < Command
  set_begin_bytes ']DTMD'
  set_tag :disable_memory
  set_status :working
end

class EnableMemory < Command
  set_begin_bytes ']DTME'
  set_tag :enable_memory
  set_status :working
end

class DisableBatchMode < Command
  set_begin_bytes '[BM0'
  set_tag :disable_batch_mode
  set_status :working

end

class EnableBatchMode < Command
  set_begin_bytes '[BM1'
  set_tag :enable_batch_mode
  set_status :working

end

class AlwaysMemorizeBatch < Command
  set_begin_bytes '[BM2'
  set_tag :always_memorize_batch
  set_status :working

end

class ClearMemory < Command
  set_begin_bytes '+-MCLR-+'
  set_tag :clear_memory
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    # Needs to sleep while it deletes everything.
    sleep 5
  end
end

class StartMemorizing < Command
  set_begin_bytes '+-MSTR-+'
  set_tag :start_memorizing
end

class StopMemorizing < Command
  set_begin_bytes '+-MSTP-+'
  set_tag :stop_memorizing
end

class TransmitMemory < Command
  set_begin_bytes '+-MXMT-+'
  set_tag :transmit_memory
  set_status :broken


  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block_until_nil
  end
end

# These commands can be found on page 10 of the OPN-3002i handbook

#use this with SendWhenFunctionPress to disable auto send
class DisableFunctionKey < Command
  set_begin_bytes '[$0D'

  set_tag :disable_function_key
  set_status :working

end

class SendWhenConnecting < Command
  set_begin_bytes '[EBB'
  set_tag :send_when_connecting
  set_status :working

end

class SendWhenFunctionPress < Command
  set_begin_bytes '[EBC'
  set_tag :send_when_function_press
  set_status :working

end

class DisableAutoSend < Command
  set_begin_bytes SendWhenFunctionPress.begin_bytes
  set_end_bytes DisableFunctionKey.begin_bytes

  set_tag :disable_auto_send
  set_status :working

end

# These commands can be found on page U92 of the UMH

class SetPreamble < Command
  set_begin_bytes 'MZ'
  set_tag :set_preamble
  set_status :working

  def self.make_data(*args)
    internal = []
    args.each do |arg|
      case
        when arg.is_a?(Symbol)
          internal << DirectInput.fix_codes[arg]
        when (arg.is_a?(String) or arg.is_a?(Numeric))
          arg.to_s.each_char {|c| internal << DirectInput.convert_to(c)}
      end
    end
    raise ArgumentError.new("***fix/amble can only have a maximum of 12 characters") if internal.count > 12
    internal
  end
end

class BlankPreamble < Command
  set_begin_bytes SetPreamble.begin_bytes
  set_tag :blank_preamble
  set_status :working

  def self.make_data(*args)
    []
  end
end

class ClearPreamble < Command
  set_begin_bytes "[XMZ"
  set_tag :clear_preamble
  set_status :working
end

class SetPrefix < SetPreamble
  set_begin_bytes 'RY'
  set_tag :set_prefix
  set_status :working
end

class BlankPrefix < Command
  set_begin_bytes SetPrefix.begin_bytes
  set_tag :blank_prefix
  set_status :working

end

class ClearPrefix < Command
  set_begin_bytes 'MG'
  set_tag :clear_prefix
  set_status :working

end

# This command can be found on page U95 of the UMH

class SetSuffix < SetPreamble
  set_begin_bytes 'RZ'
  set_tag :set_suffix
  set_status :working

end

class BlankSuffix < Command
  set_begin_bytes SetSuffix.begin_bytes
  set_tag :blank_suffix
  set_status :working

end

class ClearSuffix < Command
  set_begin_bytes 'PR'
  set_tag :clear_suffix
  set_status :working

end

class SetPostamble < SetPreamble
  set_begin_bytes 'PS'
  set_tag :set_postamble
  set_status :working

end

class BlankPostamble < Command
  set_begin_bytes SetPostamble.begin_bytes
  set_tag :blank_postamble
  set_status :working

end

class ClearPostamble < Command
  set_begin_bytes "[XOZ"
  set_tag :clear_postamble
end

# These commands were added by SerialIO

class SetSIOPrefix < SetPrefix
  set_begin_bytes '[EEB'
  set_tag :set_sio_prefix
  set_status :working

end

class BlankSIOPrefix < Command
  set_begin_bytes SetSIOPrefix.begin_bytes
  set_tag :blank_sio_prefix
end

class AlwaysMemorize < Command
  set_begin_bytes '[BMF'
  set_tag :always_memorize
end

class EnableRetentionAfterSend < Command
  set_begin_bytes '[BSE'
  set_tag :enable_retention_after_send
end

class DisableRetentionAfterSend < Command
  set_begin_bytes '[BSD'
  set_tag :disable_retention_after_send
end

#Need reclassification

class TransmitMemoryNoErase < Command
  set_begin_bytes '+-MXTO-+'
  set_tag :transmit_memory_no_erase
  set_status :broken

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block_until_nil
  end
end



class GetScanCount < Command
  set_begin_bytes '[EEQ'
  set_tag :get_scan_count
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block(7).chomp.to_i
  end
end

# used to test of the scanner was actually connected
class GetScanCountRaw < Command
  set_begin_bytes '[EEQ'
  set_tag :get_scan_count_raw
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block(7).chomp
  end
end


class GetScans < Command
  set_begin_bytes '[EBD'
  set_tag :get_scans
  set_status :working


  def self.run(opticon, *args)
    super(opticon, *args)
    #Todo: Change this to &. after 2.3.0 comes out for windows
    raw = opticon.read_block_until_nil
    raw.gsub("\r", "\n") if raw
  end
end

class GetScansRaw < Command
  set_begin_bytes '[EBD'
  set_tag :get_scans_raw
  set_status :working


  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block_until_nil_raw
  end
end

# Found on optoconfigure

# NO PROOF THESE WORK.

class LoadCustomDefaults < Command
  set_begin_bytes '[BAP'
  set_tag :load_custom_defaults
  set_status :broken
end

class StoreCustomDefaults < Command
  set_begin_bytes '[BAQ'
  set_tag :store_custom_defaults
  set_status :broken
end

