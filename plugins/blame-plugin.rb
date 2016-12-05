require 'cinch'

class BlamePlugin
  include Cinch::Plugin
  
  match /^!blame (.+)/i

  def execute(m, user)
    if user.downcase == 'asbot'
      m.reply("Yeah, it's all my... hey, wait a minute!")
    else
      m.reply("Yeah, it's all #{user}'s fault. Shame on you.")
    end
  end
end
