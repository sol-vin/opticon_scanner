require_relative './direct_input'
require_relative '../command'

# NONE OF THESE COMMANDS WORK! DO NOT USE! VERY DANGEROUS!!!! WILL BLIND SCANNER!

# These commands can be found on page 9 of the DataEdit handbook

class SetCutScript < Command
  set_begin_bytes '[ED0'
  set_tag :set_cut_script
  set_status :working

  def self.make_data(*args)
    [?' + args.first + ?']
  end
end

class SetPasteScript < Command
  set_begin_bytes '[ED1'
  set_tag :set_paste_script
  set_status :working

  def self.make_data(*args)
    [?' + args.first + ?']
  end
end

class StoreRegex < Command
  set_begin_bytes '[ED2'
  set_tag :store_regex
  set_status :working

  def self.make_data(*args)
    [DirectInput.convert_to(args.first)]
  end
end

class EnableRegex < Command
  set_begin_bytes '[ED3'
  set_tag :enable_regex
  set_status :working

  def self.make_data(*args)
    [DirectInput.convert_to(args.first)]
  end
end

class DisableRegex < Command
  set_begin_bytes '[ED4'
  set_tag :disable_regex
  set_status :working

  def self.make_data(*args)
    [DirectInput.convert_to(args.first)]
  end
end

class GetRegex < Command
  set_begin_bytes '[ED5'
  set_tag :get_regex
  set_status :broken

  def self.make_data(*args)
    [DirectInput.convert_to(args.first)]
  end

  def self.run(opticon, *args)
    super(opticon, *args)
    opticon.read_block_until_nil_raw
  end
end

class SetRegex < Command
  set_tag :set_regex
  set_status :working

  def self.make_command(*args)
    cut_script = args[0]
    paste_script = args[1]
    store_number = args[2]

    Command::BEGIN_COMMAND +
      SetCutScript.begin_bytes +
      ?' +
      cut_script +
      ?' +
      SetPasteScript.begin_bytes +
      ?' +
      paste_script +
      ?' +
      StoreRegex.begin_bytes +
      DirectInput.convert_to(store_number) +
    Command::END_COMMAND
  end
end


class ClearRegex < Command
  set_tag :clear_regex
  set_status :working

  def self.make_command(*args)
    SetRegex.make_command('', '', args.first)
  end
end

class ClearAllRegex < Command
  set_tag :clear_all_regex
  set_status :working

  def self.make_command(*args)
     ClearRegex.make_command(1) +
         ClearRegex.make_command(2) +
         ClearRegex.make_command(3) +
         ClearRegex.make_command(4)
  end
end