require 'cinch'
require_relative '../utils/utils.rb'


class RollPlugin
  include Cinch::Plugin
  rng = Random.new

  match /^(!|@)roll(\d*)? ?(\d*)?/

  def execute(m, msgtype, numberofdices, rollnumber)
    if numberofdices.to_i >= 150 && msgtype == '@'
      msgtype_reply(m, msgtype, "The roll is too big. Please consider using less than 150 rolls multiple times to achieve your result.")
    end
    rollnumber.length == 0 ? rollnumber = 10000 : rollnumber = rollnumber.to_i
    numberofdices.length == 0 ? numberofdices = 1 : numberofdices = numberofdices.to_i
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