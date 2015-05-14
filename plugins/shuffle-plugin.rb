require 'cinch'
require_relative '../utils/utils.rb'

class ShufflePlugin
  include Cinch::Plugin

  match /^(!|@)shuffle (\d+)/i

  def execute(m, msgtype, shufflenumber)
    unless shufflenumber.to_i < 0
      arrstring = (1..shufflenumber.to_i).to_a.shuffle.join(" ")
      BotUtils.msgtype_reply(m, msgtype, "Numbers from 1 to #{shufflenumber} shuffled: #{arrstring}")
    end
  end

end