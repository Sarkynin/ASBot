require 'cinch'
require_relative '../utils/utils.rb'


class ASBNaturePlugin
  include Cinch::Plugin

  match /^(!|@)asbnature (\w+) ?(.*)?/i

  def execute(m, msgtype, nature, moodycheck)
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

end