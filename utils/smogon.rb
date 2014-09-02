require 'mechanize'

class Smogon
  def initialize(login, pass)
    @agent = Mechanize.new
    self.login(login, pass)
  end

  def login(login, pass)
    page = @agent.get("http://www.smogon.com/forums/login/")
    xenf_form = page.form_with(:action => 'login/login')
    xenf_form.login = login
    xenf_form.password = pass
    xenf_form.radiobuttons_with(:name => 'register')[1].check
    page = @agent.submit(xenf_form, xenf_form.buttons.first)
  end

  def search(keywords, options = {})
    titles_only = options[:titles_only] || true
    forum_url = options[:forum_url] || "http://www.smogon.com/forums/"

    page = @agent.get(options[:forum_url])
    xenf_form = page.form_with(:action => 'search/search')
    xenf_form.keywords = keywords
    xenf_form.checkbox_with(:name => "title_only").check if titles_only == true
    page = @agent.submit(xenf_form, xenf_form.buttons.first)
    return page
  end
end