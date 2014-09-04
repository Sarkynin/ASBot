require 'cinch'

class NoPlugin
  include Cinch::Plugin
  
  match /^!no$/i,      method: :disapproval
  match /^\.\.\. *pff$/,     method: :pff

  def disapproval(m)
    m.reply("Never, not in a million years, absolutely not, no way Jose, no chance Lance, nyet, negatory, mm-mm, nuh-uh, uh-uh! And of course my own personal favourite of all time, man falling off of a cliff: NNNOOOOOOOOOoooooooo.......")
    @pfftimer = Timer(15, :shots => 1) {
      m.reply("... pff")
    }
  end

  def pff(m)
    unless @pfftimer.stopped? || @pfftimer == nil
      @pfftimer.stop
      m.reply("Hey, that's my line!")
    end
  end

end