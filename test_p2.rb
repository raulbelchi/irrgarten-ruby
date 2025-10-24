# frozen_string_literal: true
require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'
require_relative 'monster'
require_relative 'player'
require_relative 'labyrinth'
require_relative 'game_state'
require_relative 'game'

juego = Game.new(2)
estado = juego.getGameState

puts estado.labyrinth
puts estado.players
puts estado.monsters
puts estado.currentPlayer
puts estado.winner
puts estado.log