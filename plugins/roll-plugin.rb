require 'cinch'
require_relative '../utils/utils.rb'


class RollPlugin
  include Cinch::Plugin

  match /^(!|@)roll(\d+)? ?(\d+)?/i

  def execute(m, msgtype, numberofdices, rollnumber)
    rng = Random.new
    if numberofdices.to_i >= 150
      BotUtils.msgtype_reply(m, msgtype, "The number of rolls is too big. Please consider using less than 150 rolls multiple times to achieve your result.")
    else
      rollnumber.nil? ? rollnumber = 10000 : rollnumber = rollnumber.to_i
      numberofdices.nil? ? numberofdices = 1 : numberofdices = numberofdices.to_i
      if numberofdices == 1
        rollednumber = rng.rand(1..rollnumber)
        BotUtils.msgtype_reply(m, msgtype, "Rolled between 1 and #{rollnumber}: #{rollednumber}")
      else
        numberarray = Array.new
        numbersstring = String.new
        numberofdices.times do
          numberarray << rng.rand(1..rollnumber)
        end
        numberarray.each do |rollednumber|
          numbersstring << "#{rollednumber} "
        end
        BotUtils.msgtype_reply(m, msgtype, "Rolled #{numberofdices} dice between 1 and #{rollnumber}: #{numbersstring}")
      end
    end
  end

end