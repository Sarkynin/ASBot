require 'cinch'
require_relative '../utils/utils.rb'

class PickPlugin
  include Cinch::Plugin

  match /^(!|@)pick(\d+)? (.+)$/i

  def execute m, msgtype, picks, optionstring
    options = optionstring.split(',').map{|option| option.strip}
    argumenterror = "Please provide at least 2 arguments."
    BotUtils.msgtype_reply(m, msgtype, argumenterror) if options.length < 2

    pickarray = Array.new

    picks.nil? ? picks = 1 : picks = picks.to_i

    pickerror = "The number of picks should be inferior to the number of arguments."
    BotUtils.msgtype_reply(m, msgtype, pickerror) if options.length < picks.length

    picks.times do
      pickarray << options.sample
    end
    pickstring = pickarray.join(', ')
    BotUtils.msgtype_reply(m, msgtype, pickstring)
    end
  end
end