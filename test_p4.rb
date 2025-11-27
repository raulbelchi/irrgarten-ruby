# frozen_string_literal: true

require_relative 'combat_element'
require_relative 'labyrinth_character'
require_relative 'player'
require_relative 'monster'
require_relative 'weapon'
require_relative 'shield'
require_relative 'dice'
require_relative 'fuzzy_player'

module Irrgarten
  @jugador = Player.new('1', Dice.random_intelligence, Dice.random_strength)
  @monstruo = Monster.new("Monstruo 1", Dice.random_intelligence, Dice.random_strength)
  @arma = Weapon.new(Dice.weapon_power, Dice.uses_left)
  @escudo = Shield.new(Dice.shield_power, Dice.uses_left)
  @fuzzy_player = FuzzyPlayer.new(@jugador)

  puts(@jugador.to_s)
  puts(@monstruo.to_s)
  puts(@arma.to_s)
  puts(@escudo.to_s)
  puts(@fuzzy_player.to_s)
end