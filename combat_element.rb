# frozen_string_literal: true

require_relative 'dice'

module Irrgarten
  class CombatElement
    private_class_method :new

    def initialize(effect, uses)
      @effect = effect
      @uses = uses
    end

    def produce_effect
      if @uses > 0
        @uses -= 1
        return @effect
      else
        return 0
      end
    end

    def discard
      Dice.discard_element(@uses)
    end

    def to_s
      return "#{@effect}, uses=#{@uses}]"
    end
  end
end