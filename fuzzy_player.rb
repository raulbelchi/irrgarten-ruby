# frozen_string_literal: true
#
module Irrgarten
  class FuzzyPlayer < Player

    def initialize (other)
      copiar(other)
    end

    def move(direction, validMoves)
      return Dice.next_step(direction, validMoves, intelligence)
    end

    def attack
      return Dice.intensity(strength) + sum_weapons
    end

    def defensive_energy
      return Dice.intensity(intelligence) + sum_shields
    end

    #PREGUNTAR
    def to_s
      return "Fuzzy#{super}"
    end
  end
end