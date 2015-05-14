require 'cinch'
require_relative '../utils/utils.rb'


class ASBStatsPlugin
  include Cinch::Plugin
  
  match /^(!|@)asbstats (.+)/i
  def execute(m, msgtype, poke)
    $pokesheet.rows.each do |row|

      #Check if output is not an existing pokemon if it contains 'mega'

      if BotUtils.condense_name(poke) =~ /(mega|primal)/ && BotUtils.condense_name(poke) != "meganium" && BotUtils.condense_name(poke) != "yanmega"
        if BotUtils.condense_name(row[1]) == (BotUtils.condense_name(poke).sub("mega", '').sub("primal", "")) && row[0] =~ /(Primal|Mega)/
          if row[3].include?(row[4])

            #Hidden ability is the same as a regular ability, so we're hiding
            #that field

            BotUtils.msgtype_reply(m, msgtype, "#{row[0]} #{row[1]} - #{row[2]} | #{row[3].gsub(", ", "/")} | #{row[5]}/#{row[6]}/#{row[7]}/#{row[8]}/#{row[9]}/#{row[10]} | #{row[11]} BRT | Size: #{row[12]} | Weight: #{row[13]} | +Spe nat. Acc Boost: #{row[14]}%")
          else
            BotUtils.msgtype_reply(m, msgtype, "#{row[0]} #{row[1]} - #{row[2]} | #{row[3].gsub(", ", "/")}/#{row[4]} | #{row[5]}/#{row[6]}/#{row[7]}/#{row[8]}/#{row[9]}/#{row[10]} | #{row[11]} BRT | Size: #{row[12]} | Weight: #{row[13]} | +Spe nat. Acc Boost: #{row[14]}%")
          end
          return
        end
      else

        #Query is probably a non-mega/primal pokemon

        if BotUtils.condense_name(row[1]) == BotUtils.condense_name(poke)
          if row[4].length == 0

            # No hidden ability (eg. Gengar)
            
            BotUtils.msgtype_reply(m, msgtype, "#{row[1]} - #{row[2]} | #{row[3].gsub(", ", "/")} | #{row[5]}/#{row[6]}/#{row[7]}/#{row[8]}/#{row[9]}/#{row[10]} | #{row[11]} BRT | Size: #{row[12]} | Weight: #{row[13]} | +Spe nat. Acc Boost: #{row[14]}% | CC cost: #{row[16]} | #{row[17]} CHP | Sig. Item: #{row[18]} | Boosted Stats: #{row[19]}")
          else
            BotUtils.msgtype_reply(m, msgtype, "#{row[1]} - #{row[2]} | #{row[3].gsub(", ", "/")}/#{row[4]} (H) | #{row[5]}/#{row[6]}/#{row[7]}/#{row[8]}/#{row[9]}/#{row[10]} | #{row[11]} BRT | Size: #{row[12]} | Weight: #{row[13]} | +Spe nat. Acc Boost: #{row[14]}% | CC cost: #{row[16]} | #{row[17]} CHP | Sig. Item: #{row[18]} | Boosted Stats: #{row[19]}")
          end
          return
        end
      end
    end
    BotUtils.msgtype_reply(m, msgtype, "Pokemon not found.")
  end
end