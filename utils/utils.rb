$googledrivesession = GoogleDrive.login(ENV["googledrivelogin"], ENV["googledrivepass"])

$pokesheet = $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[4]
$naturesheet = $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[5]
$abilitysheet = $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[6]
$typesheet = $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[7]
$movesheet = $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[8]
$itemsheet = $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[9].rows + $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[10].rows + $googledrivesession.spreadsheet_by_key("0AiVdR0Jv-e1hdDZxVlpFOW5yRGQxb3NDSmVqRHNxVUE").worksheets[11].rows

Gist.login!(:username => ENV['githubnick'], :password => ENV["githubpass"])

module BotUtils
  def self.condense_name(name)
    return name.downcase.gsub(/[^A-Za-z0-9]/, '')
  end

  def self.msgtype_reply(m, msgtype, string)
    msgtype == "!" ? m.user.notice(string) : m.reply(string)
  end
end