# frozen_string_literal: true

module Irrgarten
  class Dice
    @@MAX_USES = 5; #número máximo de usos de armas y escudos
    @@MAX_INTELLIGENCE = 10.0; #valor máximo para la inteligencia de jugadores y monstruos
    @@MAX_STRENGTH = 10.0; #valor máximo para la fuerza de jugadores y monstruos
    @@RESURRECT_PROB = 0.3; #probabilidad de que un jugador sea resucitado en cada turno
    @@WEAPONS_REWARD = 2; #numero máximo de armas recibidas al ganar un combate
    @@SHIELDS_REWARD = 3; #numero máximo de escudos recibidos al ganar un combate
    @@HEALTH_REWARD = 5; #numero máximo de unidades de salud recibidas al ganar un combate
    @@MAX_ATTACK = 3; #máxima potencia de las armas
    @@MAX_SHIELD = 2; #máxima potencia de los escudos

    @@generator = Random.new

    def self.discard_element(uses_left)
      if(uses_left == @@MAX_USES)
        return false
      elsif(uses_left == 0)
        return true
      else
        return @@generator.rand(@@MAX_USES) >= uses_left;
      end
    end

    def self.intensity(competence)
      return @@generator.rand(competence)
    end

    def self.random_pos(max)
      return @@generator.rand(max)
    end

    def self.who_starts(nplayers)
      return @@generator.rand(nplayers)
    end

    def self.random_intelligence()
      return @@generator.rand(@@MAX_INTELLIGENCE)
    end

    def self.random_strength()
      return @@generator.rand(@@MAX_STRENGTH)
    end

    def self.resurrect_player()
      return @@generator.rand() <= @@RESURRECT_PROB
    end

    def self.weapons_reward()
      return @@generator.rand(@@WEAPONS_REWARD)
    end

    def self.shields_reward()
      return @@generator.rand(@@SHIELDS_REWARD)
    end

    def self.health_reward()
      return @@generator.rand(@@HEALTH_REWARD)
    end

    def self.weapon_power()
      return @@generator.rand(@@MAX_ATTACK)
    end

    def self.shield_power()
      return @@generator.rand(@@MAX_SHIELD)
    end

    def self.uses_left()
      return @@generator.rand(@@MAX_USES)
    end

  end
end