require 'cinch'
require 'gist'
require 'json'
require 'fileutils'
require 'uri'
require 'open-uri'

require_relative '../utils/markovchains.rb'
require_relative '../utils/utils.rb'


class MarkovPlugin
  include Cinch::Plugin

  match /(.+)/,                 method: :useline
  match /^!addbook (.+)/,       method: :addbook

  def initialize(*args)
    super

    @chain_address = config[:chain_address]
    @chain_path = "../utils/books"
    print 'Loading phrases I know... '
    raw_chain = Gist.rawify(@chain_address)
    opened_chain = open(raw_chain)
    read_chain = (opened_chain).read
    @chain = Markov.chain_from_json(read_chain)
    puts 'done.'
  end

  def useline(m, message)
    text = message.gsub(URI.regexp, '')
    name = bot.nick

    if text[0..name.size].downcase == "#{name.downcase},"
      words = text[name.size..-1].split(' ')
      seed = nil
      @chain.nodes.each do |keys, values|
        if words.reverse.any? { |word| keys.index(word) }
          seed = keys
          break
        end
      end
      sentence = @chain.generate(10, seed).join(' ') + '.'
      if sentence == '.'
        m.reply("(#{m.user.nick}) #{sentence}")
      else
        @chain.add_words(text)
        Gist.gist(JSON.dump(@chain.nodes), {:update => @chain_address, :filename => 'sentences.rb'})
      end
    end

    def addbook(m, bookurl)
      if m.user.nick == "apt-get"
        chain.add_words(open(bookurl).scan(/[A-Za-z0-9\'\-]+/).join(' '))
        m.reply("Book added.")
      end
    end
  end