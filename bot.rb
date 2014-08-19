require 'cinch'
require 'google_drive'
require 'gist'
require_relative './plugins/speed-plugin'
require_relative './plugins/roll-plugin'

require_relative './plugins/asbmove-plugin'
require_relative './plugins/asbstats-plugin'
require_relative './plugins/asbility-plugin'
require_relative './plugins/asbitem-plugin'
require_relative './plugins/asbnature-plugin'
require_relative './plugins/asbtype-plugin'

require_relative './plugins/blame-plugin'
require_relative './plugins/no-plugin'
require_relative './plugins/quotes-plugin'


bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.synirc.net"
    c.channels = ["#capasb", "#calcasb"]
    c.nick = ENV["botircnick"]
    c.password = ENV["botircpass"]
    c.plugins.prefix = ""
    c.plugins.plugins = [SpeedPlugin, ASBMovePlugin, ASBStatsPlugin, ASBilityPlugin, ASBItemPlugin, ASBNaturePlugin, ASBTypePlugin, RollPlugin, BlamePlugin, NoPlugin, QuotesPlugin]
    c.plugins.options[QuotesPlugin] = {:quotes_address => 'https://gist.github.com/Sarkynin/3f146714e4fc204ae545'}
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
