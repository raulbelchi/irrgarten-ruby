# frozen_string_literal: true
#
module Irrgarten
  class Monster
    INITIAL_HEALTH = 5

    def initialize(name, intelligence, strength)
      @name = name
      @intelligence = intelligence
      @strength = strength
      @health = INITIAL_HEALTH
      @row = -1
      @col = -1
    end

    def dead
      return @health<=0
    end

    def attack
      Dice.intensity(@strength)
    end

    def defend(received_attack)
      is_dead = dead

      if !is_dead
        defensive_energy = Dice.intensity(@intelligence)

        if defensive_energy < received_attack
          got_wounded
          is_dead = dead
        end
      end
      return is_dead
    end
    def set_pos(row, col)
      @row = row
      @col = col
    end

    def to_s
      return "Monster{ name= #{@name}, intelligence= #{@intelligence}, strength= #{@strength}, health= #{@health}, row= #{@row}, col= #{@col} }"
    end

    private
    def got_wounded
      @health -= 1
    end
  end
end