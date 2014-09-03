require 'cinch'
require 'google_drive'
require 'require_all'

require_all 'plugins' 

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.synirc.net"
    c.channels = ["#capasb", "#calcasb", "#dogbirds"]
    c.nick = ENV["botircnick"]
    c.password = ENV["botircpass"]
    c.plugins.prefix = //
    c.plugins.plugins = [SpeedPlugin, ASBMovePlugin, ASBStatsPlugin, ASBilityPlugin, ASBItemPlugin, ASBNaturePlugin, ASBTypePlugin, RollPlugin, BlamePlugin, NoPlugin, QuotesPlugin, ProfilePlugin, ComboPlugin, HelpPlugin, DCCheckPlugin, YesPlugin, ShufflePlugin, LearnPlugin, RecapPlugin]
    c.plugins.options[QuotesPlugin] = {:quotes_address => ENV["quotes_url"]}
    c.plugins.options[ProfilePlugin] = {:smogon_username => ENV["smogon_username"], :smogon_password => ENV["smogon_password"]}
    c.plugins.options[RecapPlugin] = {
      :mode => :max_messages,
      :max_messages => 25,
      :time_format => "%H:%M",
      :channels => c.channels
    }

  end

  on :connect do |m|
    $movesheet.rows[0][0]
    $pokesheet.rows[0][0]
    $abilitysheet.rows[0][0]
    $itemsheet[0][0]
    $typesheet.rows[0][0]
    $naturesheet.rows[0][0]
  end

end

bot.start
