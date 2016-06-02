class Commands
  class << self
    attr_reader :commands

    def add_command(command)
      @commands ||= []
      @commands << command
      $LOG.debug("[#{__FILE__.split(?/).last}]Command added #{command.tag}")
    end

    def run(tag, opticon, *args)
      get_command(tag).run(opticon, *args)
    end

    def get_command(tag)
      commands.find {|c| c.tag == tag}
    end
  end
end