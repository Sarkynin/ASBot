require 'cinch'
require 'google_drive'
require 'require_all'
require_relative 'utils/utils.rb'

require_all 'plugins' 

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.synirc.net"
    c.channels = ["#capasb", "#calcasb", "#dogbirds", "#ircasb", "#autismcraft"]
    c.nick = ENV["botircnick"]
    c.password = ENV["botircpass"]
    c.plugins.prefix = //
    c.plugins.plugins = [SpeedPlugin, ASBMovePlugin, ASBStatsPlugin,
                         ASBilityPlugin, ASBItemPlugin, ASBNaturePlugin,
                         ASBTypePlugin, RollPlugin, BlamePlugin, NoPlugin,
                         QuotesPlugin, ProfilePlugin, ComboPlugin, HelpPlugin,
                         DCCheckPlugin, YesPlugin, ShufflePlugin, LearnPlugin,
                         UpdateNDAPlugin, CalcPlugin]
    c.plugins.options[QuotesPlugin] = {:quotes_address => ENV["quotes_url"]}
    c.plugins.options[ProfilePlugin] = {:smogon_username => ENV["smogon_username"], :smogon_password => ENV["smogon_password"]}
    # c.plugins.options[RecapPlugin] = {
    #   :mode => :max_messages,
    #   :max_messages => 25,
    #   :time_format => "%H:%M",
    #   :channels => c.channels,
    #   :cooldown => 60
    # }

  end

  on :connect do |m|
    BotUtils.updatenda
  end

end

bot.start
