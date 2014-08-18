require 'cinch'
require_relative '../utils/utils.rb'

class ASBItemPlugin
  include Cinch::Plugin
  
  match /^(!|@)asbitem (.+)/

  def execute(m, msgtype, item)
    itemfound = false
    $itemsheet.each do |row|
      if BotUtils.condense_name(row[0]) == BotUtils.condense_name(item)
        BotUtils.msgtype_reply(m, msgtype, "#{row[0]} | Item Type: #{row[1]} | Cost: #{row[2]} | Affected Pokemon: #{row[4]} | Max Uses Per Match: #{row[5]} | Trigger: #{row[6] == "" ? "N/A" : row[6]} | Nat. Gift Type: #{row[7]} | Nat. Gift BAP: #{row[8]}")
        BotUtils.msgtype_reply(m, msgtype, "#{row[3]}".gsub("é","e"))
        itemfound = true
      end
    end
    if itemfound == false
      BotUtils.msgtype_reply(m, msgtype, "Item not found.")
    end
  end
end