require 'cinch'
require_relative '../utils/utils.rb'
require 'text-table'

class ASBMovePlugin
  include Cinch::Plugin

  match /^(!|@)asbmove (.+)/i

  def execute(m, msgtype, move)
    movefound = false

    $movesheet.rows.each.with_index do |row, index|
      if BotUtils.condense_name(row[0].gsub(" (Move)", "")) == BotUtils.condense_name(move)
        BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index][0].sub(" (Move)", "")} - #{$movesheet.rows[index][1]} | #{$movesheet.rows[index][2]} | #{$movesheet.rows[index][3]} | #{$movesheet.rows[index][6]} BAP | #{$movesheet.rows[index][8]} Acc | #{$movesheet.rows[index][9]} EN Cost | #{$movesheet.rows[index][10]} Eff% | Contact: #{$movesheet.rows[index][11]} | #{$movesheet.rows[index][12]} Prio | Combo Type: #{$movesheet.rows[index][13]} | Snatch: #{$movesheet.rows[index][14]} | Magic Coat: #{$movesheet.rows[index][15]}")
        extralines = 2

        if BotUtils.condense_name(row[6]) == "table"
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
          if msgtype == '@'
            BotUtils.msgtype_reply(m, msgtype, "Please use !asbmove for the table.")
          else
            tablearray = Array.new
            tablearray << $movesheet.rows[index+extralines][1..15].reject &:empty?

            while $movesheet.rows[index+extralines+1][0] == ""
              uncleanedline = $movesheet.rows[index+extralines][1..15]
              cleanedline = (uncleanedline[1..14].reject &:empty?).unshift("")
              tablearray << cleanedline
              extralines += 1
            end
            BotUtils.msgtype_reply(m, msgtype, tablearray.to_table(:first_row_is_head => true))
          else
            BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
            while $movesheet.rows[index+extralines][0] == ""
              BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+extralines][1]}".gsub("é","e"))
              extralines += 1
            end
          end
        end
      end

      movefound = true
    end
  end
  if movefound == false
    BotUtils.msgtype_reply(m, msgtype, "Move not found.")
  end
end
end