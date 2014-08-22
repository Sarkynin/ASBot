require 'cinch'
require_relative '../utils/utils.rb'

class ASBMovePlugin
  include Cinch::Plugin

  match /^(!|@)asbmove (.+)/i

  def execute(m, msgtype, move)
    
    fourlinemoves = ["batonpass", "smokescreen", "circlethrow"]
    threelinemoves = ["agility", "clearsmog", "eggbomb", "haze", "mist", "smog", "bide", "bodyslam", "bounce", "bravebird", "counter", "doubleedge", "echoedvoice", "endeavor", "flareblitz", "furycutter", "gigaimpact", "headcharge", "headsmash", "heatcrash", "heavyslam", "iceball", "mefirst", "metalburst", "mirrorcoat", "psychic", "rollout", "skydrop", "stormthrow", "superfang", "tackle", "takedown", "volttackle", "wildcharge", "woodhammer"]
    twolinemoves = ["stealthrock", "copycat", "crushgrip", "detect", "doubleteam", "eruption", "fairylock", "finalgambit", "flash", "guardsplit", "gyroball", "healorder", "helpinghand", "kinesis", "kingsshield", "metronome", "milkdrink", "mirrormove", "moonlight", "morningsun", "mudslap", "naturepower", "painsplit", "powersplit", "protect", "punishment", "recover", "roost", "sandattack", "seismictoss", "slackoff", "sleeptalk", "snatch", "softboiled", "spikyshield", "stealthrock", "steamroller", "stomp", "storedpower", "submission", "synthesis", "vitalthrow", "waterspout", "wish"]
    tablemoves = ["electroball", "flail", "fling", "grassknot", "lowkick", "magnitude", "present", "reversal", "substitute"]

    movefound = false
    $movesheet.rows.each.with_index do |row, index|
      if BotUtils.condense_name(row[0].gsub(" (Move)", "")) == BotUtils.condense_name(move)
        BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index][0].sub(" (Move)", "")} - #{$movesheet.rows[index][1]} | #{$movesheet.rows[index][2]} | #{$movesheet.rows[index][3]} | #{$movesheet.rows[index][6]} BAP | #{$movesheet.rows[index][8]} Acc | #{$movesheet.rows[index][9]} EN Cost | #{$movesheet.rows[index][10]} Eff% | Contact: #{$movesheet.rows[index][11]} | #{$movesheet.rows[index][12]} Prio | Combo Type: #{$movesheet.rows[index][13]} | Snatch: #{$movesheet.rows[index][14]} | Magic Coat: #{$movesheet.rows[index][15]}")
        
        if fourlinemoves.include?(BotUtils.condense_name(move))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+2][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+3][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+4][1]}".gsub("é","e"))

        elsif threelinemoves.include?(BotUtils.condense_name(move))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+2][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+3][1]}".gsub("é","e"))

        elsif twolinemoves.include?(BotUtils.condense_name(move))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+2][1]}".gsub("é","e"))

        elsif tablemoves.include?(BotUtils.condense_name(move))
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
          BotUtils.msgtype_reply(m, msgtype, "Please check the NDA for the table.")

        else
          BotUtils.msgtype_reply(m, msgtype, "#{$movesheet.rows[index+1][1]}".gsub("é","e"))
        end
        movefound = true
      end
    end
    if movefound == false
      BotUtils.msgtype_reply(m, msgtype, "Move not found.")
    end
  end
end