require 'gist'
require 'google_drive'
require "google/api_client"

def request_token
  auth = Signet::OAuth2::Client.new(
    token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
    audience: 'https://accounts.google.com/o/oauth2/token',
    scope: ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"].join(' '),
    issuer: ENV["googledrivelogin"],
    access_type: 'offline',
    signing_key: Google::APIClient::KeyUtils.load_from_pkcs12('utils/google_key.p12', ENV['p12pass'])
    )
  auth.fetch_access_token!

  $googledrivesession = GoogleDrive.login_with_oauth(auth.access_token)
end

request_token
Gist.login!(:username => ENV['githubnick'], :password => ENV["githubpass"])


module BotUtils
  def self.condense_name(name)
    return name.downcase.gsub(/[^A-Za-z0-9]/, '')
  end

  def self.msgtype_reply(m, msgtype, input)
    input = input.gsub("é", "e") if input.is_a? String
    msgtype == "!" ? m.user.notice(input) : m.reply(input)
  end

  def self.auth?(m, user)
    return m.channel.voiced?(m.user.nick) || m.channel.half_opped?(m.user.nick) || m.channel.opped?(m.user.nick)
  end

  def self.updatenda opts = {:reload => false}
    request_token
    nda_link = '0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE'
    $pokesheet = $googledrivesession.spreadsheet_by_key(nda_link).worksheets[4]
    $naturesheet = $googledrivesession.spreadsheet_by_key(nda_link).worksheets[5]
    $abilitysheet = $googledrivesession.spreadsheet_by_key(nda_link).worksheets[6]
    $typesheet = $googledrivesession.spreadsheet_by_key(nda_link).worksheets[7]
    $movesheet = $googledrivesession.spreadsheet_by_key(nda_link).worksheets[8]
    $itemsheet = $googledrivesession.spreadsheet_by_key(nda_link).worksheets[9].rows + $googledrivesession.spreadsheet_by_key(nda_link).worksheets[10].rows + $googledrivesession.spreadsheet_by_key(nda_link).worksheets[11].rows + $googledrivesession.spreadsheet_by_key(nda_link).worksheet[12].rows

    $movesheet.rows[0][0]
    $pokesheet.rows[0][0]
    $abilitysheet.rows[0][0]
    $typesheet.rows[0][0]
    $naturesheet.rows[0][0]
    $itemsheet[0][0]
  end
end
