require 'cinch'
require_relative '../utils/utils.rb'
require 'random/online'

class RollPlugin
  include Cinch::Plugin

  match /^(!|@)roll(\d+)? ?(\d+)?/i

  def execute(m, msgtype, numberofdices, rollnumber)

    if numberofdices.to_i >= 30
      error = "The number of rolls is too big. Please consider using less than 30 rolls multiple times to achieve your result."
      BotUtils.msgtype_reply(m, msgtype, error)
      return
    end

    rollnumber.nil? ? rollnumber = 10000 : rollnumber = rollnumber.to_i
    numberofdices.nil? ? numberofdices = 1 : numberofdices = numberofdices.to_i
    numbers_string = String.new

    begin
      rng = RealRand::RandomOrg.new

      numbers_string = rng.randnum(numberofdices, 1, rollnumber).join(", ")
    rescue
      rng = Random.new

      numbers_array = Array.new
      numbers_string = String.new

      numberofdices.times { numbers_array << rng.rand(1..rollnumber) }
      numbers_string = numbers_array.join(', ')        
    end

    if numberofdices == 1
      BotUtils.msgtype_reply(m, msgtype, "Rolled between 1 and #{rollnumber}: #{numbers_string}")
    else
      BotUtils.msgtype_reply(m, msgtype, "Rolled #{numberofdices} dices between 1 and #{rollnumber}: #{numbers_string}")
    end

  end
end