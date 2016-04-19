require 'cinch'
require_relative '../utils/utils.rb'


class ASBRankPlugin
  include Cinch::Plugin
  
  match /^(!|@)asbrank (.+)/i

  def execute(m, msgtype, item)
    $ranksheet.rows.each do |row|      
      if BotUtils.condense_name(row[0]) == BotUtils.condense_name(item)
        BotUtils.msgtype_reply(m, msgtype, "#{row[0]}'#{'s' if row[0][-1].downcase!='s'} Rank: #{row[3]}")
        return
      end
    end
    BotUtils.msgtype_reply(m, msgtype, "Pokemon not found.")
  end
end
