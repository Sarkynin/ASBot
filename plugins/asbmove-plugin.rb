require 'cinch'
require_relative '../utils/utils.rb'


class ASBMovePlugin
  include Cinch::Plugin

  match /^(!|@)asbmove (.+)/i

  def execute(m, msgtype, move)
    $movesheet.rows.each.with_index do |row, index|

      #Move names on the sheet are followed by either " (Move)" or " (Command)",
      #so we need to remove those to verify the move

      if BotUtils.condense_name(row[0].gsub(" (Move)", "").gsub(" (Command)","") ) == BotUtils.condense_name(move)
        BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index][0].sub(" (Move)", "")} - #{$movesheet.rows[index][1]} | #{$movesheet.rows[index][2]} | #{$movesheet.rows[index][3]} | #{$movesheet.rows[index][6]} BAP | #{$movesheet.rows[index][8]} Acc | #{$movesheet.rows[index][9]} EN Cost | #{$movesheet.rows[index][10]} Eff% | Contact: #{$movesheet.rows[index][11]} | #{$movesheet.rows[index][12]} Prio | Z-BAP: #{$movesheet.rows[index][13]} | Combo Type: #{$movesheet.rows[index][14]} | Snatch: #{$movesheet.rows[index][15]} | Magic Coat: #{$movesheet.rows[index][16]}")
        extralines = 2

        if BotUtils.condense_name(row[6]) == "table"
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}")
          BotUtils.msgtype_reply(m, msgtype, "Please check the NDA for the table.")
        else

          #Some moves have more than one line of description

          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}")
          while $movesheet.rows[index+extralines][0] == ""
            BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+extralines][1]}")
            extralines += 1
          end
        end
        return
      end
    end
    BotUtils.msgtype_reply(m, msgtype, "Move not found.")
  end
end
