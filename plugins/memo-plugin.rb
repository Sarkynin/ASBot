# adapted from the following script
# source:  https://github.com/telemachus/antinoos/blob/master/memo.rb
# license: https://github.com/telemachus/antinoos/blob/master/LICENSE

require 'yaml'
require 'gist'
require 'open-uri'
require 'cinch'

class MemoPlugin
  include Cinch::Plugin

  def initialize(*args)
    super
    @memos_address = config[:memos_address]
    @memos = get_memos
  end

  listen_to :message
  match /^!memo (.+) (.+)/

  def listen(m)
    if @memos.key?(m.user.nick) and @memos[m.user.nick].size > 0
      while @memos[m.user.nick].size > 0
        msg = @memos[m.user.nick].shift
        m.reply msg
      end
      @memos.delete m.user.nick
      update_store
    end
  end

  def execute(m, nick, message)
    if nick == m.user.nick
      m.reply "You can't leave memos for yourself."
    elsif nick == bot.nick
      m.reply "You can't leave memos for me."
    elsif !nick.authed?
      m.reply "This nick is not registered."
    elsif @memos && @memos.key?(nick)
      msg = make_msg(m.user.nick, message, Time.now)
      @memos[nick] << msg
      m.reply "Added memo for #{nick}"
      update_store
    else
      @memos[nick] ||= []
      msg = make_msg(m.user.nick, message, Time.now)
      @memos[nick] << msg
      m.reply "Added memo for #{nick}"
      update_store
    end
  end

  def update_store
    Gist.gist(YAML.dump(@memos), {:update => @memos_address, 
                                  :filename => 'memos.rb'})
  end

  def make_msg(nick, text, time)
    t = time.strftime("%Y-%m-%d")
    "[#{t}] <#{nick}>: #{text}"
  end

  #--------------------------------------------------------------------------------
  # Protected
  #--------------------------------------------------------------------------------
  
  protected

  def get_memos
    raw_memos = Gist.rawify(@memos)
    opened_memos = open(raw_memos)
    read_memos = (opened_memos).read
    memos = YAML.load(read_memos)
    return memos
  end
end
