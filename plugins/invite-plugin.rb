require 'cinch'

class InvitePlugin
  include Cinch::Plugin

  listen_to :invite, method: :on_invite

  def on_invite(m)
    bot.join(m.channel)
  end
end