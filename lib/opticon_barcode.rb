require 'barby'
require 'barby/outputter/html_outputter'
require 'barby/barcode/qr_code'

require_relative 'barcode/opticon_code_39.rb'

class OpticonBarcode

  BARCODE_BEGIN = "@MENU_OPTO@ZZ@".freeze
  BARCODE_END = "@ZZ@OTPO_UNEM@".freeze
  QR_SEPARATOR = ?@

  #Commands that need to be ignored and not produce barcodes!
  IGNORED_LIST = [
      :set_time
  ]

  #Commands that must be in QR format
  QR_LIST = [
    :bluesnap_master_mode,
    :bluesnap_slave_mode,
    :reset_defaults
  ]

  class << self
    # Makes a sheet of barcodes in array format
    def make_sheet(refurb_name, settings = {})
      # reset the barcodes list
      @qr_codes = []
      @code_39_codes = []
      # put the settings somewhere analog to opticon
      @settings = settings

      # Add a clear memory barcode at the top if speified
      run(:clear_memory) if settings[:clear_memory]

      @code_39_codes << OpticonBarcode.new(:set_barcode)

      # run the refurb block in this context
      instance_exec &OpticonRefurbs[refurb_name]

      @code_39_codes << OpticonBarcode.new(:set_barcode)

      @code_39_codes + @qr_codes
    end

    private

    # private method analog to opticon#run. Adds a barcode with the specified command and data
    def run(tag, *args)
      unless IGNORED_LIST.include? tag
        barcode = OpticonBarcode.new(tag, *args)
        if barcode.is_code_39?
          @code_39_codes << barcode
        elsif barcode.is_qr?
          @qr_codes << barcode
        end
      end
    end

    #private methods for dealing with settings
    def settings
      @settings
    end

    def settings=(sets)
      @settings = sets
    end

    def [] key
      @settings[key]
    end
  end

  attr_reader :command, :data

  def initialize(tag, *args)
    @command =  Commands.get_command(tag)
    @data = command.make_data(*args)
  end

  # Is this code a QR code?
  def is_qr?
    QR_LIST.include? command.tag or !data.empty? or !command.end_bytes.empty?
  end

  # Is this code a 1D code?
  def is_code_39?
    (data.empty? and command.end_bytes.empty?) or (command.begin_bytes.include?('+-') and command.begin_bytes.include?('-+'))
  end

  # What the data would be if it was in QR format
  def qr_data
    barcode = ''
    barcode << BARCODE_BEGIN
    barcode << command.begin_bytes.gsub(/[\[\]]/, '')
    barcode << QR_SEPARATOR
    barcode << data.join(QR_SEPARATOR).gsub(/[\[\]]/, '')
    barcode << QR_SEPARATOR
    barcode << command.end_bytes.gsub(/[\[\]]/, '')
    barcode << BARCODE_END

    barcode.gsub!(QR_SEPARATOR*2, QR_SEPARATOR) while barcode.include? QR_SEPARATOR*2
    barcode
  end

  # What the data would look like if it was 1D
  def code_39_data
    barcode = []
    barcode << command.begin_bytes.gsub(/[\[\]]/, '') unless command.begin_bytes.empty?
    barcode << data.map {|d| d.gsub(/[\[\]]/, '')} unless data.empty?
    barcode << command.end_bytes.gsub(/[\[\]]/, '') unless command.end_bytes.empty?
    barcode.flatten
  end

  # Output the QR code as html
  def to_qr_html
    #Make the code and rename the css class to reflect the qr css
    Barby::QrCode.new(qr_data).to_html.gsub("barby", "barby-qr")
  end

  # Output the Code39 code as html
  def to_opticon_code_39_html
    barcodes = code_39_data.map { |barcode_data| OpticonCode39.new(barcode_data).to_html }

    #Make the code and rename the css class to reflect the c39 css
    barcodes.join('<br><br>').gsub("barby", "barby-op")
  end

  # Decides what the html output should be then returns it.
  def to_html
    if is_qr?
      to_qr_html
    elsif is_code_39?
      to_opticon_code_39_html
    else
      to_qr_html
    end
  end
end
