class DirectInput
  @chars = {}
  (?0..?9).each {|x| @chars[x] = "Q#{x}"}
  (?a..?z).each {|x| @chars[x] = "$#{x}"}
  (?A..?Z).each {|x| @chars[x] = "0#{x}"}
  @chars[' '] = "5A"
  @chars[?!] = "5B"
  @chars[?"] = "5C"
  @chars[?#] = "5D"
  @chars[?$] = "5E"
  @chars[?%] = "5F"
  @chars[?&] = "5G"
  @chars[?'] = "5H"
  @chars[?(] = "5I"
  @chars[?)] = "5J"
  @chars[?*] = "5K"
  @chars[?+] = "5L"
  @chars[?,] = "5M"
  @chars[?-] = "5N"
  @chars[?.] = "5O"
  @chars[?/] = "5P"
  @chars[?:] = "6A"
  @chars[?;] = "6B"
  @chars[?<] = "6C"
  @chars[?=] = "6D"
  @chars[?>] = "6E"
  @chars[??] = "6F"
  @chars[?@] = "6G"
  @chars[?[] = "7A"
  @chars[?\\] = "7B"
  @chars[?]] = "7C"
  @chars[?^] = "7D"
  @chars[?_] = "7E"
  @chars[?`] = "7F"
  @chars[?{] = "9T"
  @chars[?|] = "9U"
  @chars[?}] = "9V"
  @chars[?~] = "9W"
  @chars[?\x00] = "9G"
  @chars[?\x01] = "1A"
  @chars[?\x02] = "1B"
  @chars[?\x03] = "1C"
  @chars[?\x04] = "1D"
  @chars[?\x05] = "1E"
  @chars[?\x06] = "1F"
  @chars[?\x07] = "1G"
  @chars[?\x08] = "1H"
  @chars[?\x09] = "1I"
  @chars[?\x0A] = "1J"
  @chars[?\x0B] = "1K"
  @chars[?\x0C] = "1L"
  @chars[?\x0D] = "1M"
  @chars[?\x0E] = "1N"
  @chars[?\x0F] = "1O"
  @chars[?\x10] = "1P"
  @chars[?\x11] = "1Q"
  @chars[?\x12] = "1R"
  @chars[?\x13] = "1S"
  @chars[?\x14] = "1T"
  @chars[?\x15] = "1U"
  @chars[?\x16] = "1V"
  @chars[?\x17] = "1W"
  @chars[?\x18] = "1X"
  @chars[?\x19] = "1Y"
  @chars[?\x1A] = "1Z"
  @chars[?\x1B] = "9A"
  @chars[?\x1C] = "9B"
  @chars[?\x1D] = "9C"
  @chars[?\x1E] = "9D"
  @chars[?\x1F] = "9E"
  @chars[?\x7F] = "9F"

  @fix_codes = {
      serial_number: "[$ID",
      timestamp: "[$TM",
      year: "[$YR",
      month: "[$MO",
      day: "[$DY",
      hour: "[HR",
      minute: "[$MI",
      second: "[$SC",
      scan_count: "[$CT",
      barcode_type: "[$BT",
      barcode_length: "[$BL",
      battery_voltage: "[$BV",
      bt_address: "[$AR",
      terminal_id: "[$ID",
      terminal_name: "[$NM"
  }

  class << self
    attr_reader :chars
    attr_reader :fix_codes
  end

  def self.convert_to(item)
    item = item.to_s
    di_string = ""
    item.each_char do |char|
      di_string << chars[char]
    end
    di_string
  end

  def self.convert_from(di_string)
    di_chars = di_string.each_char.each_slice(2).map(&:join)
    di_chars.map! do |di_char|
      chars.key(di_char)
    end
    di_chars.join
  end
end