require_relative './commands'

# Basic command class
class Command

  # Beginning of the command
  BEGIN_COMMAND = "\x1B"
  # end of the command
  END_COMMAND = "\x0D"

  # class level members
  class << self

    # Name to find this command in Commands
    attr_reader :tag, :begin_bytes, :end_bytes
    attr_reader :status

    def causes_disconnect?
      @causes_disconnect
    end

    def reconnects_manually?
      @reconnect_type == :manual
    end

    def reconnects_automatically?
      @reconnect_type == :automatic
    end

    protected

    # sets the bytes var like a DSL
    def set_begin_bytes bytes
      @begin_bytes = bytes
    end

    def set_end_bytes bytes
      @end_bytes = bytes
    end

    # sets the tag var like a DSL
    def set_tag tag
      @tag = tag
    end

    def set_status status
      @status = status
    end

    def causes_disconnect bool
      @causes_disconnect = bool
    end

    def reconnect_type type
      @reconnect_type = type
    end

    # inherited hook to add new child commands to Commands
    def inherited base
      Commands.add_command(base)

      # TODO: How does this call protected methods from an object?
      # Maybe has something to do with the class we are currently in?
      base.set_begin_bytes ''
      base.set_end_bytes ''
      base.set_tag :NO_TAG
      base.set_status :untested
      base.causes_disconnect false
      base.reconnect_type :none
    end

    public

    # puts the command together to send to the scanner. Returns a string
    def make_command(*args)
      BEGIN_COMMAND + begin_bytes + make_data(*args).join + end_bytes + END_COMMAND
    end

    # returns an array of arguments ready to pack
    def make_data(*args)
      []
    end

    # Run this command
    def run(opticon, *args)
      $LOG.info("[#{__FILE__.split(?/).last}]Running command #{tag}#{args} on #{(opticon.settings) ? opticon[:serial_number] : "AUN(#{opticon.port.name}"}")

      written = opticon.write(make_command(*args))
      sleep 1
      if causes_disconnect?
        puts "Please manually reconnect the device" if reconnects_manually?
        unless opticon.wait_for_connection(30)
          $LOG.info("[#{__FILE__.split(?/).last}]Did not reconnect! #{(opticon.settings) ? opticon[:serial_number] : "AUN(#{opticon.port.name || "UNKNOWN"}"}")
        end
      end

      $LOG.info("[#{__FILE__.split(?/).last}]Ran command #{tag}#{args} on #{(opticon.settings) ? opticon[:serial_number] : "AUN(#{opticon.port.name}"}")
      written
    end
  end
end
