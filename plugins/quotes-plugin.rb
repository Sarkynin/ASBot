# The original script is made by Caitlin Woodward
# This is a modified version made to work with Github Gists
# original repo here: https://github.com/caitlin/cinch-quotes

require 'cinch'
require 'gist'
require 'open-uri'
require 'yaml'

class QuotesPlugin
  include Cinch::Plugin

  match /^!addquote (.+)/i,  method: :addquote
  match /^!quote (.+)/i,     method: :quote
  match "^!quote",           method: :quote

  def initialize(*args)
    super

    @quotes_address = config[:quotes_address]
  end

  def addquote(m, quote)
    # make the quote
    new_quote = { "quote" => quote, "added_by" => m.user.nick, "created_at" => Time.now, "deleted" => false }
    # add it to the list
    existing_quotes = get_quotes || []
    existing_quotes << new_quote
    # find the id of the new quote and set it based on where it was placed in the quote list
    new_quote_index = existing_quotes.index(new_quote)
    existing_quotes[new_quote_index]["id"] = new_quote_index + 1
    # write it to the gist
    Gist.gist(YAML.dump(existing_quotes), {:update => @quotes_address, :filename => 'quotes.rb'})
    # send reply that quote was added
    m.reply "#{m.user.nick}: Quote successfully added as ##{new_quote_index + 1}."
  end

  def quote(m, search = nil)
    quotes = get_quotes.delete_if{ |q| q["deleted"] == true }
    if search.nil? # we are pulling random
      quote = quotes.sample
      m.reply "#{m.user.nick}: ##{quote["id"]} - #{quote["quote"]}"
    elsif search.to_i != 0 # then we are searching by id
      quote = quotes.find{|q| q["id"] == search.to_i }
      if quote.nil?
        m.reply "#{m.user.nick}: No quotes found."
      else 
        m.reply "#{m.user.nick}: ##{quote["id"]} - #{quote["quote"]}"
      end
    else 
      quotes.keep_if{ |q| q["quote"].downcase.include?(search.downcase) }
      if quotes.empty?
        m.reply "#{m.user.nick}: No quotes found."
      else
        quote = quotes.sample
        m.reply "#{m.user.nick}: ##{quote["id"]} - #{quote["quote"]}"
      end
    end
  end

  #--------------------------------------------------------------------------------
  # Protected
  #--------------------------------------------------------------------------------
  
  protected

  def get_quotes
    raw_quotes = Gist.rawify(@quotes_address)
    opened_quotes = open(raw_quotes)
    read_quotes = (opened_quotes).read
    quotes = YAML.load(read_quotes)
    return quotes
  end

end
