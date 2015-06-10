require 'cinch'
require_relative '../utils/utils.rb'


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
      if BotUtils.condense_name(row[1]).include?(BotUtils.condense_name(boost1)) && BotUtils.condense_name(row[1]).include?(BotUtils.condense_name(boost2))
        BotUtils.msgtype_reply(m, msgtype, "The corresponding nature is #{row[0].strip}.")
        return
      end
    end
    BotUtils.msgtype_reply(m, msgtype, "Nature not found.")
  end

end