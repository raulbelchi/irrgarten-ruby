# frozen_string_literal: true
require_relative 'dice'

class Shield
  DADO = Dice.new

  def initialize(protection, uses)
    @protection = protection
    @uses = uses
  end

  def to_s
    return "S[#{@protection}, #{@uses}]"
  end

  def protect()
    if (@uses > 0)
      @uses -= 1
      return @protection
    else
      return 0
    end
  end

  def discard()
    DADO.discardElement(@uses)
  end
end
