require 'cinch'
require_relative '../utils/utils.rb'

class HelpPlugin
  include Cinch::Plugin

  match /^(!|@)asbot$/i,        method: :asbot_commands
  match /^(!|@)asbot (.+)$/i,   method: :asbot_commandhelp

  def initialize(*args)
    super

    @commands = {
      "asbstats" => "!asbstats <pokemon> - Gives a Pokémon's stats and informations in ASB.",
      "asbmove" => "!asbmove <move> - Gives a move's data and description in ASB.",
      "asbility" => "!asbility <ability> - Gives an ability's data and description in ASB.",
      "asbitem" => "!asbitem <item> - Gives an item's data and description in ASB.\nWorks for held items, consumable items, and signature items.",
      "asbnature" => "!asbnature <nature> - Gives a nature's effects in ASB.\nPutting \"moody\" after the nature will give the effect of the nature with the ability Moody.",
      "speed" => "!speed <speed number> [accuracy value] - Gives the value a Pokémon's speed will achieve with a positive and a negative nature.\nEntering an accuracy value after the speed number will calculate the pokémon's accuracy boost with a positive nature.\nValid accuracy values: 1/2, 1/3, 2/3, FE.",
      "roll" => "!roll[number of rolls] [maximum value] - Gives a random number.\nSimply typing !roll will generate a roll between 1 and 10000.\nInserting a number in the [maximum value] field will limit the roll's maximum value to the number entered, while concatenating a number directly to the !roll will generate as many rolls as the number entered.",
      "profile" => "!profile <username> - Links to a user's profile thread.",
      "combo" => "!combo <EnergyCost1>[, EnergyCost2] - Calculates a same-move combo's energy cost.\nIf another number is entered afterwards, it will calculate these moves' energy costs when used in a combo together.",
      "blame" => "!blame <user> - Blames a user.",
      "no" => "!no - Shows your disapproval.",
      "yes" => "!yes - Shows your approval.",
      "addquote" => "!addquote <quote> - Adds a quote to the quote database.",
      "quote" => "!quote [Quote ID | Search term] - Displays a random quote from the quote database.\nIf a quote ID is used, the quote with that ID will be displayed.\nIf a search term is entered, a random quote that includes the search term will be displayed.",
      "dc-check" => "\"dc check\" - Returns a message.\nUsed to test if you are still connected to the server.",
      "recap" => "!recap - Returns the last 25 messages.\nUseful to see the context of a discussion when joining a channel.\nCurrently disabled due to issues.",
      "shuffle" => "!shuffle <number> - Builds up an array from 1 to the number entered, shuffles the numbers, and returns the array.",
      "learn" => "!pklearn <pokemon> <move> - Checks if a pokémon can learn a move." ,
      "source" => "https://github.com/sarkynin/asbot",
      "updatenda" => "!updatenda - Updates the local NDA database.\nOnly accessible to VOP and up.",
      "calc" => "!calc <expression> - Calculates the given expression.\nAvailable functions: round(), floor(), ceil().\nAvailables variables: pi",
      "thread" => "http://www.smogon.com/forums/threads/asbot-capasb-utility-bot.3538380/",
      "pick" => "!pick[number of picks] <argument1>, <argument2>[, <argument3>[, <argument...>]] - Picks a random sample from the provided arguments.\n If [number of picks] is specified, it will sample x items from the arguments.",
      "findnature" => "!findnature <boost1>, <boost2> - Finds the nature corresponding to the boosts given.\nBoosts are generally given in the \"+x stat\" format."
    }
  end
  
  def asbot_commands(m, msgtype)
    BotUtils.msgtype_reply(m, msgtype, "Available commands: #{@commands.keys.join(", ")}")
  end

  def asbot_commandhelp(m, msgtype, command)
    if @commands[BotUtils.condense_name(command)] == nil
      BotUtils.msgtype_reply("Command not found. To see available commands, type \"#{msgtype}asbot\".")
    else
      BotUtils.msgtype_reply(m, msgtype, "#{command}: #{@commands[BotUtils.condense_name(command)]}")
    end
  end

end