require 'cinch'
require_relative '../utils/smogon.rb'
require_relative '../utils/utils.rb'

class ProfilePlugin
  include Cinch::Plugin

  match /^(!|@)profile (.+)/i

  def initialize(*args)
    super

    @smogon_username = config[:smogon_username]
    @smogon_password = config[:smogon_password]
  end


  def execute(m, msgtype, user)
    smogsearch = Smogon.new(@smogon_username, @smogon_password)

     page = smogsearch.search("profile #{user}", forum_url: "http://www.smogon.com/forums/forums/registration-center.252/")

    if page.body.include?("No results found.")
      BotUtils.msgtype_reply(m, msgtype, "No user found.")
    else

      #Look for first link
      
      profilelink = page.search("//h3[@class=\"title\"]/a").map { |link| link['href'] }[0]
      BotUtils.msgtype_reply(m, msgtype, "#{user}'s profile: http://www.smogon.com/forums/#{profilelink}")
    end
  end

end