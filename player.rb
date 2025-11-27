# frozen_string_literal: true
require_relative 'shield'
require_relative 'weapon'
require_relative 'labyrinth_character'

module Irrgarten

  class Player < LabyrinthCharacter

    public_class_method :new

    #getters
    attr_reader :number

    MAX_WEAPONS = 2
    MAX_SHIELDS = 3
    INITIAL_HEALTH = 10
    HITS2LOSE = 3

    def initialize(number, intelligence, strength)
      super("Player ##{number}", intelligence, strength, INITIAL_HEALTH)
      @number = number
      @consecutive_hits = 0
      @weapons = []
      @shields = []
    end

    def copiar(other)
      super(other)
      @number = other.number
      @consecutive_hits = 0
      @weapons = []
      @shields = []
    end

    def resurrect
      @weapons.clear
      @shields.clear
      @health = INITIAL_HEALTH
      @consecutive_hits = 0
    end

    def set_pos(row, col)
      @row = row
      @col = col
    end

    def move(direction, valid_moves)
      size = valid_moves.size
      contained = valid_moves.include?(direction)

      if size > 0 && !contained
        return valid_moves[0]
      else
        return direction
      end
    end

    def attack
      return @strength + sum_weapons
    end

    def defend(received_attack)
      return manage_hit(received_attack)
    end

    def receive_reward
      w_reward = Dice.weapons_reward
      s_reward = Dice.shields_reward

      w_reward.times do
        w_new = new_weapon
        receive_weapon(w_new)
      end

      s_reward.times do
        s_new = new_shield
        receive_shield(s_new)
      end

      extra_health = Dice.health_reward
      @health += extra_health
    end

    def to_s
      return "Player#{super.to_s}, number=#{@number}, consecutiveHits=#{@consecutive_hits}\nweapons=#{@weapons}\nshields=#{@shields}\n}"
    end

    private #A partir de aquí los métodos son privados
    def receive_weapon(w)

      @weapons.each do |wi|
        discard = wi.discard

        if discard
          @weapons.delete(wi)
        end
      end

      size = @weapons.size

      if size < MAX_WEAPONS
        @weapons.push(w)
      end
    end

    def receive_shield(s)
      @shields.each do |si|
        discard = si.discard

        if discard
          @shields.delete(si)
        end
      end

      size = @shields.size

      if size < MAX_SHIELDS
        @shields.push(s)
      end
    end

    def new_weapon
      return Weapon.new(Dice.weapon_power, Dice.uses_left)
    end

    def new_shield
      return Shield.new(Dice.shield_power, Dice.uses_left)
    end

    def sum_weapons
      total = 0
      @weapons.each do |w|
        total += w.attack
      end
      return total
    end

    def sum_shields
      total = 0
      @shields.each do |s|
        total += s.protect
      end
      return total
    end

    def defensive_energy
      return @intelligence + sum_shields
    end

    def manage_hit(received_attack)
      defense = defensive_energy

      if defense < received_attack
        got_wounded
        inc_consecutive_hits
      else
        reset_hits
      end

      if @consecutive_hits == HITS2LOSE || dead
        reset_hits
        lose = true
      else
        lose = false
      end

      return lose
    end

    def reset_hits
      @consecutive_hits = 0
    end

    def inc_consecutive_hits
       @consecutive_hits += 1
    end

  end
end