require 'cinch'
require 'sequel'
require_relative '../utils/utils.rb'

class LearnPlugin
  include Cinch::Plugin
  def initialize(*args)
    super
    @db = Sequel.connect(ENV['DATABASE_URL'])
  end

  match /^(!|@)pklearn (.+), *(.+)$/i

  def execute(m, msgtype, pokemon, move)

    pokerow = @db[:pokemon].filter(:identifier => BotUtils.condense_name(pokemon)).first
    if pokerow.nil?
      BotUtils.msgtype_reply(m, msgtype, "Pokémon not found.")
      return
    end
    pokeid = pokerow[:id]
    pokename = @db[:pokemon_species_names].filter(:local_language_id => 9, :pokemon_species_id => pokerow[:species_id]).first

    moveid = @db[:moves].filter(:identifier => BotUtils.condense_name(move)).first
    if moveid.nil?
      BotUtils.msgtype_reply(m, msgtype, "Move not found.")
      return
    end
    movename  = @db[:move_names].filter(:local_language_id => 9, :move_id => moveid).first

    movefound = !@db[:pokemon_moves].filter(:pokemon_id => pokeid, :move_id => moveid).first.nil?

    if movefound
      string = "#{pokename} #{Format(:green, "can")} learn #{movename}."
      BotUtils.msgtype_reply(m, msgtype, string)
    else
      string = "#{pokename} #{Format(:red, "cannot")} learn #{movename}."
      BotUtils.msgtype_reply(m, msgtype, string)
    end
  end

end