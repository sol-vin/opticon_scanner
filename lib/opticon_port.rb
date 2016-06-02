require 'rubyserial'
#Note: opticon and opticonPort are almost interchangable when using a Command.run method
#EX: GetSettings(n) == GetSettings(n.port)
#Be careful with this as it might not always be the case.


class OpticonPort < Serial
  #device the port is on
  attr_reader :name

  # time between getting chars using read_block_until_nil
  attr_accessor :interchar_timeout
  # time computer will wait for opticon to respond.
  attr_reader :timeout

  attr_reader :baud_rate

  alias_method :get_byte, :getbyte

  def initialize(device, baud = 9600)
    super(device, baud)

    @baud_rate = baud
    @name = device
    @interchar_timeout = 3
    @timeout = 5
  end

  def read_block_raw(chars)
    $LOG.info "[#{__FILE__.split(?/).last}] read_block #{chars}"
    #start the clock
    start_time = Time.now

    #while we haven't timed out
    while timeout > (Time.now - start_time) do
      #try to get a byte
      char = get_byte
      #was the byte nil?
      unless char.nil?
        return (char.chr + read(chars-1)) #chars-1 because we already got the first char
      end
    end
    false #It timed out
  end

  def read_block(chars)
    read_block_raw(chars).gsub(?\x00, '')
  end

  # reads from scanner until it hits a nil and has no more data.
  def read_block_until_nil_raw
    $LOG.info "[#{__FILE__.split(?/).last}] read_block_until_nil"
    start_time = Time.now
    #wait until device is ready
    until char = get_byte
      #wait
      #exit with false if timeout is reached
      return nil if timeout < (Time.now - start_time)
    end

    #Grab the first char
    data = char.chr

    start_time = Time.now
    #Grab chars until a nil or interchar_timeout is reached
    while (char = get_byte) or interchar_timeout > (Time.now - start_time)
      # check if there is data on the line, if not keep waiting and increment the timer.
      unless char.nil?
        #add the char to our string
        data << char.chr
        #reset the interchar_timeout
        start_time = Time.now
      end
    end
    data
  end

  def read_block_until_nil
    read_block_until_nil_raw.gsub(?\x00, '')
  end

  # reads a specified number of lines
  def read_lines_block_raw(lines)
    start_time = Time.now

    #wait until device is ready
    until char = get_byte
      #wait
      #exit with false if timeout is reached
      return false if timeout < (Time.now - start_time)
    end

    data = char.chr

    read_lines = 0
    #Grab chars until a nil or interchar_timeout is reached
    while ((char = get_byte) and lines > read_lines) or interchar_timeout > (Time.now - start_time)
      # check if there is data on the line, if not keep waiting and increment the timer.
      unless char.nil?
        #replace /r with /n
        if char.chr == Command::END_COMMAND
          char = "\n".ord
          read_lines += 1
        end
        #add the char to our string
        data << char.chr
        start_time = Time.now
      end
    end
    data
  end

  def read_lines_block(lines)
    data = read_lines_block_raw(lines)
    data.gsub(?\x00, '') if data
  end

  # Reads one line
  def read_block_until_return
    read_lines_block 1
  end

  def read_block_until_char_raw end_char
    start_time = Time.now

    #wait until device is ready
    until char = get_byte
      #wait
      #exit with false if timeout is reached
      return false if timeout < (Time.now - start_time)
    end

    data = char.chr

    while (char = get_byte and char != end_char) or interchar_timeout > (Time.now - start_time)
      # check if there is data on the line, if not keep waiting and increment the timer.
      unless char.nil?
        #add the char to our string
        data << char.chr
        start_time = Time.now
      end
    end
    data << char.chr
    data
  end

  def read_block_until_char(end_char)
    read_block_until_char_raw(end_char).gsub(?\x00, '')
  end
end