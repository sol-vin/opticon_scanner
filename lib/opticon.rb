require 'rubyserial'
require 'require_all'
require 'os'
require 'open3'

require_relative './command'
require_relative './commands'
require_relative './opticon_port.rb'
require_relative './opticon_refurbs'

#requires all commands from the command directory and subfolders.
#requiring the command adds it to the Commands list
require_rel 'commands'

# opticon scanner object.
class Opticon
  @scanners = []

  #Class level stuff to deal with finding scanners
  class << self

    attr_reader :scanners

    def clean
      @scanners.delete_if {|s| s.closed?}
      #run through devices and make sure they don't have errors
      @scanners.select! do |s|
        begin
          #try to run a command, if it throws an error then we take it out.
          s.test_live?
        rescue RubySerial::Exception => e
          false
        end
      end
    end

    def search_by_list(devices_in)
      devices = devices_in.dup
      devices.delete_if {|device| scanners.any?{|s| s.port.name == device}}
      threads = []
      devices.each do |tty|
        threads << Thread.new do
          start_time = Time.now
          begin
            n = Opticon.new tty
            fail IOError unless n.test_live?
            @scanners << n
            $LOG.info "[#{__FILE__.split(?/).last}] Found scanner #{n[:serial_number]}"
          rescue RubySerial::Exception => e
            # EBUSY is produced when scanner disconnects then reconnects.
            # Just keep trying the device until it errors out with a real error or works
            if e.to_s == "EBUSY"
              $LOG.info "[#{__FILE__.split(?/).last}] Scanner read EBUSY #{tty}, retrying in 3 seconds"
              unless (Time.now - start_time) > 30
                sleep 3
                retry
              end
            end
            #Throw away the scanner if it raised exceptions
            n.close if n
          end
        end
      end
      while threads.any?(&:alive?)
        #wait for all the threads to join
      end
      threads.each(&:join)
      scanners.count
    end

    MAX_WINDOWS_DEVICES = 254
    WINDOWS_DEV_NAME = "COM".freeze

    def search_windows
      clean
      devices = Array(0..MAX_WINDOWS_DEVICES).map {|x| WINDOWS_DEV_NAME + x.to_s}
      search_by_list(devices)
    end

    LINUX_DEVICE_PATH = "/dev/serial/by-path/".freeze

    def search_linux
      clean
      #Run through the devices in /dev/ that might have what we are looking for
      devices = Open3.capture3("ls #{LINUX_DEVICE_PATH}")[0].each_line.map(&:chomp)
      devices.map! {|device| LINUX_DEVICE_PATH + device}
      search_by_list(devices)
    end

    def search_by_sn(serial)
      # try to find the scanner first
      scanner = scanners.find {|s| s[:serial_number] == serial}
      # test the scanner to make sure it works
      scanner_alive = false
      scanner_alive = scanner.test_live? if scanner
      # if it didn't work or we didnt find the scanner search again
      unless scanner_alive
        search
        scanner = scanners.find {|s| s[:serial_number] == serial}
      end
      scanner
    end

    def [] serial
      search_by_sn(serial.to_s.rjust(6, ?0))
    end

    #Finds scanners attached to a computer.
    #Just a heads up, Windows does not have a way to query serial ports so you have to brute force it(COM0-COM254)
    #Linux you just ls /dev/ | grep ttyUSB to find potential scanners
    def search
      @last_search_time ||= Time.now
      if Time.now - @last_search_time > 5
        $LOG.info "[#{__FILE__.split(?/).last}]Searching for opticons"
        @last_search_time = Time.now
      end
      case
        when OS.windows?
          search_windows
        when OS.linux?
          search_linux
        else
          fail "OS NOT SUPPORTED"
      end
    end

    #scanners helper methods

    def each &block
      Opticon.search
      threads = []
      scanners.each do |opticon|
        threads << Thread.new do
          opticon.run_batch &block
        end
      end

      while threads.any?(&:alive?)
        #wait for all the threads to join
      end
      threads.each(&:join)
    end

    def count
      scanners.count
    end
  end

  # rubyserial port
  attr_reader :port

  attr_reader :settings

  def initialize(device)
    @port = OpticonPort.new(device)

    while get_byte
      #bleed scanner
    end
    #sleep(1)
    #get the initial settings to determine if it is an opticon scanner
    begin
      refresh_settings
    rescue IOError
      port.close
    ensure
      #sleep(1)
      #bleed the scanner of data
      while get_byte
        #bleed scanner
      end
    end
  end

  # run a command by name
  def run(name, *args)
    Commands.run(name, self, *args)
  end

  #lets you run multiple commands at once by instance_exec
  def run_batch &block
    instance_exec &block
  end

  def run_refurb(name)
    run_batch &OpticonRefurbs[name]
  end

  def test_live?
    alive = false
    begin
      alive = run(:get_scan_count_raw) =~ /\d{6}/
    rescue RubySerial::Exception => e
      alive = false
    end
    alive
  end

  # reads anf parses the settings into the settings hash
  def refresh_settings
    $LOG.info "[#{__FILE__.split(?/).last}] Refreshing settings on #{(settings) ? self[:serial_number] : "AUN(#{self.port.name}"}"
    fresh_settings = run(:get_settings)
    fail IOError unless fresh_settings #Fail so non-opticon scanners aren't  considered opticon in search
    parse_settings fresh_settings
  end

  def parse_settings(settings)
    @settings = {}
    #check to see if it is using ack_nak handshaking
    if settings.include?(?\x06) or settings.include?(?\x15)
      @settings[:handshake_mode] = :ack_nak
    else
      @settings[:handshake_mode] = :no_handshake
    end

    #get model
    @settings[:model] = settings.lines.grep(/Model/)[0].split(?=).last.gsub(' ', '').chomp

    #get versioning
    versioning = settings.lines.grep(/Ver\./)[0].gsub(/\s+/, ' ').split(' ')[2..5]
    @settings[:os_ver] = versioning[0].split(':').last
    @settings[:mdi_ver] = versioning[1].split(':').last
    @settings[:bt_ver] = versioning[2].split(':').last

    #get serial number
    @settings[:serial_number] = settings.lines.grep(/Serial No\./)[0].delete(' ').split('=').last.chomp

    #get read mode
    @settings[:read_mode] = case settings.lines.grep(/Barcode Read Mode/)[0]
                   when /Single/
                     :single_read
                   when /Multiple/
                     :multiple_read
                   when /Continuous/
                     :continuous_read
                 end

    #get local bluetooth address
    @settings[:local_bluetooth_address] = settings.lines.grep(/Local Bluetooth Address/)[0].delete(' ').split('=').last.chomp
    #get local bluetooth name
    @settings[:local_bluetooth_name] = settings.lines.grep(/Local Bluetooth Name/)[0].delete(' ').split('=').last.chomp
    #get bluetooth communications mode
    @settings[:bluetooth_communication_mode] = settings.lines.grep(/Communication Mode/)[0].delete(' ').split('=').last.chomp
    #get remote bluetooth address
    @settings[:remote_bluetooth_address] = settings.lines.grep(/Remote Bluetooth Address/)[0].delete(' ').split('=').last.chomp
    #get remote bluetooth name
    @settings[:remote_bluetooth_name] = settings.lines.grep(/Remote Bluetooth Name/)[0].delete(' ').split('=').last.chomp
    #get bluetooth pin code
    @settings[:bluetooth_pin_code] = settings.lines.grep(/PIN Code/)[0].delete(' ').split('=').last.chomp
    #get pin code input mode
    @settings[:bluetooth_pin_code_input_mode] = settings.lines.grep(/PIN Code Input Mode/)[0].delete(' ').split('=').last.chomp
    #get usb communication
    @settings[:usb_communication] = (settings.lines.grep(/USB Communication/)[0] =~ /Enable/) != nil

    unless settings.lines.grep(/AP Config Check Sum/)[0]
      fail "#{self[:serial_number]} failed to get_settings"
    end

    #get os/ap checksum (if u get an error on this line its because get_settings didn't get everything from the port)
    @settings[:os_ap_checksum] = settings.lines.grep(/AP Config Check Sum/)[0].delete(' ').split(':').last.chomp

    $LOG.info "[#{__FILE__.split(?/).last}]Finished getting settings for #{self[:serial_number]}"
  end

  def get_scans_to_file(tag  = '', folder = './')
    f = File.open("#{folder}#{self[:serial_number]}.#{tag.to_s}.txt", "w+")
    f.write run(:get_scans)
    f.close
  end

  #Simplified port methods
  #Added these so OpticonPort and opticon would be near interchangable via Command.run
  def reopen
    port.close if port
    @port = OpticonPort.new port.port_name
  end

  def open(device)
    port.close if port
    @port_name = device
    @port = OpticonPort.new port_name
  end

  def wait_for_connection(wait_seconds)
    $LOG.info("[#{__FILE__.split(?/).last}] Waiting for #{wait_seconds} until #{(settings) ? self[:serial_number] : "AUN(#{self.port.name}"} reconnects")
    port.close

    start_time = Time.now

    while (Time.now - start_time) < wait_seconds
      Opticon.search
      if opticon[self[:serial_number]]
        @port = opticon[self[:serial_number]].port
        refresh_settings
        $LOG.info("[#{__FILE__.split(?/).last}] Reconnected #{self[:serial_number]}")

        return true
      end
    end
    false
  end

  def ==(other)
    self[:serial_number] == other[:serial_number]
  end

  # settings helper methods
  def [] key
    settings[key]
  end

  # port helper methods

  PORT_METHODS = [:close, :closed?, :write, :get_byte, :read_block,
  :read_block_until_nil, :read_lines_block, :read_block_until_return]

  PORT_METHODS.each do |method_name|
    define_method(method_name) do |*args|
      port.send(method_name, *args)
    end

    define_method(method_name.to_s + "_raw") do |*args|
      port.send(method_name.to_s + "_raw", *args)
    end
  end
end