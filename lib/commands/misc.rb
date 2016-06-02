require_relative '../command'

class SendPrimaryMessageOnly < Command
  set_begin_bytes '[BDE'
  set_tag :send_primary_message_only
end