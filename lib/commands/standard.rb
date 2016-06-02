require_relative '../command'

class GetROMChecksum < Command
  set_begin_bytes 'ZY'
  set_tag :get_rom_checksum
  set_status :working


  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_lines_block(1).chomp
  end
end

class GetVersion < Command
  set_begin_bytes 'Z1'
  set_tag :get_version
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_lines_block(1).chomp
  end
end

class SaveSettings < Command
  set_begin_bytes 'Z2'
  set_tag :save_settings
  set_status :working

end

class GetSettings < Command
  set_begin_bytes 'Z3'
  set_tag :get_settings
  set_status :working


  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_lines_block(89)
  end
end

class ResetDefaults < Command
  set_begin_bytes ']INIT'
  set_tag :reset_defaults
  set_status :working
  causes_disconnect true
  reconnect_type :manual
end

class SetTime < Command
  set_begin_bytes '[SDT'
  set_tag :set_time
  set_status :working

  def self.make_data(*args)
    data = ''
    if args.first.is_a? String
      data << args.first #TODO: REGEX Date
    elsif args.first.is_a? Time
      data << args.first.year.to_s.rjust(4, "0")
      data << args.first.month.to_s.rjust(2, "0")
      data << args.first.day.to_s.rjust(2, "0")
      data << args.first.hour.to_s.rjust(2, "0")
      data << args.first.min.to_s.rjust(2, "0")
      data << args.first.sec.to_s.rjust(2, "0")
    end
    [data]
  end
end

class GetASCIIControlString < Command
  set_begin_bytes 'YV'
  set_tag :get_ascii_control_string
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block_until_return
  end
end

class GetASCIIPrintableString < Command
  set_begin_bytes 'ZA'
  set_tag :get_ascii_printable_string
  set_status :working

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block_until_return
  end
end

class AutoShutdownTime < Command
  set_begin_bytes "[BBB"
  set_tag :auto_shutdown_time

  def self.make_data(*args)
    data = []
    args.first.to_s.each_char do |c|
      data << DirectInput.convert_to(c)
    end
    data
  end
end

class SetBarcode < Command
  set_begin_bytes 'ZZ'
  set_tag :set_barcode
  set_status :working

end