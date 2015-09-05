require 'cinch'

class YololPlugin
  include Cinch::Plugin
  
  match /^!yolol/i

  def execute(m)
    m.reply("yolol") unless m.user.nick.downcase == "matezoide"
  end
end
