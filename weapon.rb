# frozen_string_literal: true
require_relative 'dice'
require_relative 'combat_element'

module Irrgarten

  class Weapon < CombatElement

    public_class_method :new

    def initialize(power, uses)
      super(power, uses)
    end

    def to_s
      return "W[power=#{super.to_s}"
    end

    def attack
      produce_effect
    end

  end
end