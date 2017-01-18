require 'cinch'
require 'dentaku'
require_relative '../utils/utils.rb'


class CalcPlugin
  include Cinch::Plugin

  match /^(!|@)calc (.+)/i

    def initialize(*args)
      super
      @calculator = Dentaku::Calculator.new

      @calculator.add_function(
      name: :floor,
      type: :numeric,
      signature: [:numeric],
      body: ->(n) { n.floor }
      )

      @calculator.add_function(
      name: :ceil,
      type: :numeric,
      signature: [:numeric],
      body: ->(n) { n.ceil }
      )

      @calculator.store(pi: 3.14159265359)

    end

  def execute(m, msgtype, calc)

    begin
      result = @calculator.evaluate(calc)

      if result.nil?
        BotUtils.msgtype_reply(m, msgtype, "Error in the formula!")
      elsif result.is_a?(BigDecimal)

        #BigDecimals show up as scientific notation, which is not acceptable

        BotUtils.msgtype_reply(m, msgtype, result.to_f)
      else
        BotUtils.msgtype_reply(m, msgtype, result)
      end

    #Erroneous functions will make ruby crash, so we have to rescue

    rescue
      BotUtils.msgtype_reply(m, msgtype, "Error in the formula!")
    end

  end
end
