# frozen_string_literal: true
require_relative 'dice'
require_relative 'combat_element'

module Irrgarten
  class Shield < CombatElement

    public_class_method :new

    def initialize(protection, uses)
      super(protection, uses)
    end

    def to_s
      return "S[protection=#{super.to_s}"
    end

    def protect
      produce_effect
    end

  end
end