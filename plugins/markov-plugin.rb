require 'cinch'
require 'gist'
require 'json'
require 'fileutils'
require 'uri'
require_relative '../utils/markovchains.rb'
require_relative '../utils/utils.rb'


class MarkovPlugin
  include Cinch::Plugin

  match /(.+)/,                 method: :useline

  def initialize(*args)
    super

    @chain_address = config[:chain_address]
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
      m.reply("(#{m.user.nick}) #{@chain.generate(10, seed).join(' ')}.")
    else
      @chain.add_words(text)
      Gist.gist(JSON.dump(@chain.nodes), {:update => @chain_address, :filename => 'sentences.rb'})
    end
  end
end