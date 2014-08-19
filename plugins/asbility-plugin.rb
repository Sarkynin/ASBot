require 'cinch'
require_relative '../utils/utils.rb'

class ASBilityPlugin
  include Cinch::Plugin
  
  match /^(!|@)asbility (.+)/i

  def execute(m, msgtype, ability)
    abilityfound = false
    $abilitysheet.rows.each do |row|
      if BotUtils.condense_name(row[0]) == BotUtils.condense_name(ability)
        BotUtils.msgtype_reply(m, msgtype, "#{row[0]} | Type: #{row[1]} | Mold Breaker-affected: #{row[3]}")
        BotUtils.msgtype_reply(m, msgtype, "#{row[2]}".gsub("é","e"))
        abilityfound = true
      end
    end
    if abilityfound == false
      BotUtils.msgtype_reply(m, msgtype, "Ability not found.")
    end
  end

end