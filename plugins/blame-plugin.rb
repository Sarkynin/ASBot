require 'cinch'

class BlamePlugin
  include Cinch::Plugin
  
  match /^!blame (.+)/i

  def execute(m, user)
    m.reply("Yeah, it's all #{user}'s fault. Shame on you.")
  end
end