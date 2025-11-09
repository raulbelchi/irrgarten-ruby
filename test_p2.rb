# frozen_string_literal: true
require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'
require_relative 'monster'
require_relative 'player'
require_relative 'labyrinth'
require_relative 'game_state'
require_relative 'game'

module Irrgarten
  juego = Game.new(2)
  estado = juego.get_game_state

  puts estado.labyrinth
  puts estado.players
  puts estado.monsters
  puts estado.current_player
  puts estado.winner
  puts estado.log
end