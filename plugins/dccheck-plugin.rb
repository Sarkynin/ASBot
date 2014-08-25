require 'cinch'

class DCCheckPlugin
  include Cinch::Plugin

  match /^dc check$/i
    
  def execute(m)
    m.user.notice("You're still connected.")
  end

end