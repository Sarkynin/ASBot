require 'cinch'
require_relative '../utils/utils.rb'

class ASBNaturePlugin
  include Cinch::Plugin

  match /^(!|@)asbnature (\w+) ?(.*)?/i

  def execute(m, msgtype, nature, moodycheck)
    naturefound = false
    $naturesheet.rows.each do |row|
      if BotUtils.condense_name(row[0]) == BotUtils.condense_name(nature)
        if moodycheck == 'moody'
          BotUtils.msgtype_reply(m, msgtype, "#{row[0]}: #{ row[2].gsub(/[\(\)]/, '') } with Moody activated.")
        else
          BotUtils.msgtype_reply(m, msgtype, "#{row[0]}: #{ row[1].gsub(/[\(\)]/, '') }")
        end
        naturefound = true
      end
    end
    if naturefound == false
      BotUtils.msgtype_reply(m, msgtype, "Nature not found.")
    end
  end

end