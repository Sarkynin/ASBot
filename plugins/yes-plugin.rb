require 'cinch'

class YesPlugin
  include Cinch::Plugin
  
  match /^!yes$/i,     method: :approval
  match /^\.\.\. *sss$/,     method: :sss

  def approval(m)
    m.reply("Always, yes in a million years, absolutely so, yes way Jose, yes chance Lance, dah, affirmitive, mm-hmm, yuh-huh, uh-huh! And of course my own personal favourite of all time, man winning the lottery: YYYEEEEEEEEEssssssss.......")
    @ssstimer = Timer(15, :shots => 1) {
      m.reply("... sss")
    }
  end

  def sss(m)
    unless @ssstimer.stopped? || @ssstimer == nil
      @ssstimer.stop
      m.reply("Hey, that's my line!")
    end
  end

end