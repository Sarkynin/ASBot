require 'cinch'
require_relative '../utils/utils.rb'


class ComboPlugin
  include Cinch::Plugin

  match /^(!|@)combo (\d+)$/i,            method: :combosame
  match /^(!|@)combo (\d+), *(\d+)$/i,    method: :combodifferent

  def combosame(m, msgtype, energy)

    energycost = (energy.to_f + 2) * 3.5

    if energycost.round(1) - energycost.to_i == 0.5
      energycost = energycost.round - 0.5
    else
      energycost = energycost.round
    end

    BotUtils.msgtype_reply(m, msgtype, "Energy cost: #{energycost.round(1)}")
  end

  def combodifferent(m, msgtype, energy1, energy2)
    energycost = (energy1.to_f + energy2.to_f) * 1.5
    if energycost.round(1) - energycost.to_i == 0.5
      energycost = energycost.round - 0.5
    else
      energycost = energycost.round
    end
    BotUtils.msgtype_reply(m, msgtype, "Energy cost: #{energycost.round(1)}")
  end

end