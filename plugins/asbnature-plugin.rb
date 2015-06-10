require 'cinch'
require_relative '../utils/utils.rb'

def reduce_string str
  str.downcase.gsub(/\s+/, "")
end


class ASBNaturePlugin
  include Cinch::Plugin

  match /^(!|@)asbnature (\w+) ?(.*)?/i,     method: :asbnature
  match /^(!|@)findnature (.+)[ ]+(.+)/i,    method: :findnature

  def asbnature(m, msgtype, nature, moodycheck)
    $naturesheet.rows.each do |row|
      if BotUtils.condense_name(row[0]) == BotUtils.condense_name(nature)
        if moodycheck == 'moody'
          BotUtils.msgtype_reply(m, msgtype, "#{row[0]}: #{ row[2].gsub(/[\(\)]/, '') } with Moody activated.")
        else
          BotUtils.msgtype_reply(m, msgtype, "#{row[0]}: #{ row[1].gsub(/[\(\)]/, '') }")
        end
        return
      end
    end
    BotUtils.msgtype_reply(m, msgtype, "Nature not found.")
  end

  def findnature(m, msgtype, boost1, boost2)
    $naturesheet.rows.each do |row|
      message = reduce_string(row[1]).gsub('speed÷', '-speed').gsub('%speed', '+speed')
      if message.include?(reduce_string(boost1)) && message.include?(reduce_string(boost2))
        BotUtils.msgtype_reply(m, msgtype, "The corresponding nature is #{row[0].strip}.")
        return
      end
    end
    BotUtils.msgtype_reply(m, msgtype, "Nature not found.")
  end

end