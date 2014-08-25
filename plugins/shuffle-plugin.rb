require 'cinch'
require_relative '../utils/utils.rb'

class ShufflePlugin
  include Cinch::Plugin

  match /^(!|@)shuffle (\d*)/i

  def execute(m, msgtype, shufflenumber)
    unless shufflenumber < 0
      arrstring = (1..shufflenumber).to_a.join(" ")
      BotUtils.msgtype_reply(m, msgtype, "Numbers from 1 to #{shufflenumber} shuffled: #{arrstring}")
    end
  end

end