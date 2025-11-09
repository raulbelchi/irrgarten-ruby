# frozen_string_literal: true
require_relative 'dice'

module Irrgarten
  class Weapon

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
      Dice.discard_element(@uses)
    end
  end
end