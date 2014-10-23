require 'cinch'
require_relative '../utils/utils.rb'

class UpdateNDAPlugin
  include Cinch::Plugin

  match /^!(updatenda|ndaupdate)/i

  def execute(m)
    if BotUtils.auth?(m, m.user.nick)
      BotUtils.updatenda
      BotUtils.msgtype_reply(m, '@', "local NDA updated.")
    end
  end

end