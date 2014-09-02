require 'cinch'
require 'sqlite3'
require_relative '../utils/utils.rb'

class LearnPlugin
  include Cinch::Plugin
  def initialize(*args)
    super
    @db = SQLite3::Database.new "./utils/pokedex.sqlite"
  end

  match /^(!|@)pklearn (.+), *(.+)$/i

  def execute(m, msgtype, pokemon, move)
    stm = @db.prepare "SELECT * FROM pokemon WHERE identifier=?" 
    stm.bind_param 1, BotUtils.condense_name(pokemon)
    pokerow = stm.execute.next
    if pokerow.nil?
      BotUtils.msgtype_reply(m, msgtype, "Pokémon not found.")
      return
    end
    pokeid = pokerow[0]

    stm = @db.prepare "SELECT id FROM moves WHERE identifier=?" 
    stm.bind_param 1, BotUtils.condense_name(move)
    moveid = stm.execute.next
    if moveid.nil?
      BotUtils.msgtype_reply(m, msgtype, "Move not found.")
      return
    end
    moveid = moveid[0]

    stm = @db.prepare("SELECT name FROM pokemon_species_names WHERE pokemon_species_id=? AND local_language_id=9")
    stm.bind_param 1, pokerow[2]
    pokename = stm.execute.next[0]

    stm = @db.prepare("SELECT name FROM move_names WHERE move_id=? AND local_language_id=9")
    stm.bind_param 1, moveid
    movename = stm.execute.next[0]


    stm = @db.prepare("SELECT 1 FROM pokemon_moves WHERE pokemon_id=? AND move_id=?")
    stm.bind_param 1, pokeid
    stm.bind_param 2, moveid
    movefound = !stm.execute.next.nil?
    if movefound
      string = "#{pokename} #{Format(:green, "can")} learn #{movename}."
      BotUtils.msgtype_reply(m, msgtype, string)
    else
      string = "#{pokename} #{Format(:red, "cannot")} learn #{movename}."
      BotUtils.msgtype_reply(m, msgtype, string)
    end
  end

end