require 'cinch'
require_relative '../utils/utils.rb'

class PickPlugin
  include Cinch::Plugin

  match /^(!|@)pick (.+)$/i

  def execute m, msgtype, optionstring
    options = optionstring.split(',').map{|option| option.strip}
    if options.length < 2
      BotUtils.msgtype_reply(m, msgtype, "Please provide at least 2 arguments.")
    else
      BotUtils.msgtype_reply(m, msgtype, options.sample)
    end
  end
end