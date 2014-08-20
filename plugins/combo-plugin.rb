require 'cinch'
require_relative '../utils/utils.rb'

class ComboPlugin
  include Cinch::Plugin

  match /^(!|@)combo (.+)/i,           method: :combosame
  match /^(!|@)combo (.+), *(.+)/i,    method: :combodifferent

  def combosame(m, msgtype, energy)
    energycost = (energy + 2) * 3.5
    BotUtils.msgtype_reply(m, msgtype, "Energy cost: #{energycost}")
  end

  def combodifferent(m, msgtype, energy1, energy2)
    energycost = (energy1 + energy2) * 1.5
    BotUtils.msgtype_reply(m, msgtype, "Energy cost: #{energycost}")
  end

end