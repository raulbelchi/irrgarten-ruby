# frozen_string_literal: true
require_relative 'dice'

class Weapon
  DADO = Dice.new

  def initialize(power, uses)
    @power = power
    @uses = uses
  end

  def to_s
    return "W[#{@power}, #{@uses}]"
  end

  def attack()
    if (@uses > 0)
      @uses -= 1
      return @power
    else
      return 0
    end
  end

  def discard()
    DADO.discardElement(@uses)
  end
end
