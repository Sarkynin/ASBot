require 'cinch'

class NoPlugin
  include Cinch::Plugin
  
  match "!no"

  def execute(m)
    m.reply("Never, not in a million years, absolutely not, no way Jose, no chance Lance, nyet, negatory, mm-mm, nuh-uh, uh-uh! And of course my own personal favourite of all time, man falling off of a cliff: NNNOOOOOOOOOoooooooo.......")
    sleep 15
    m.reply("... pff")
  end

end