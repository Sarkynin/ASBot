require 'cinch'
require_relative '../utils/utils.rb'

class SpeedPlugin
  include Cinch::Plugin

  match /^(!|@)speed (\d+) ?(.*)?/i

  def execute(m, msgtype, speed, details)
    speedplus = speed.to_f*1.15
    speedminus = speed.to_f/1.15
    calcaccuracy = true
    validdetailsvalues = %w[1/2 1/3 2/3 FE]

    if details == "fe"
      currentevo, finalevo = 1.0, 1.0
    elsif %w[1/2 1/3 2/3].include?(details)
      detailsarray = details.split("/")
      currentevo, finalevo = Float(detailsarray[0]), Float(detailsarray[1])
    elsif details == ''
      calcaccuracy = false
    else
      validstring = validdetailsvalues[0..-2].join(', ') + ", and " + validdetailsvalues.last
      BotUtils.msgtype_reply(m, msgtype, "Invalid evolution stage. Valid values are #{validstring}.")
    end

    BotUtils.msgtype_reply(m, msgtype, "#{speed} speed gets boosted to #{speedplus.ceil} speed (#{speedplus.round(2)} unrounded).")
    if calcaccuracy == true
      accboost = (speedplus.ceil**2)/(870 * currentevo / finalevo)
      accboost < 5 ? accboost = 5 : accboost
      accboost > 30 ? accboost = 30 : accboost
      BotUtils.msgtype_reply(m, msgtype, "This gives an accuracy boost of #{accboost.round}% (#{accboost.round(2)}% unrounded).")
    end
    BotUtils.msgtype_reply(m, msgtype, "With a -speed nature, the speed drops to #{speedminus.floor} (#{speedminus.round(2)} unrounded).")

  end
end