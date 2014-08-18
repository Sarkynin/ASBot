require 'cinch'
require_relative '../utils/utils.rb'

class ASBTypePlugin
  include Cinch::Plugin
  
  match /^(!|@)asbtype (.+)/
  def execute(m, msgtype, poketype)
    typefound = false
    $typesheet.rows.each do |row|
      if BotUtils.condense_name(row[0]) == BotUtils.condense_name(poketype)
        BotUtils.msgtype_reply(m, msgtype, "#{row[1]}".gsub("é","e"))
        typefound = true
      end
    end
    if typefound == false
      BotUtils.msgtype_reply(m, msgtype, "Type not found.")
    end
  end

end