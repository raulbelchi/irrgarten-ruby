# frozen_string_literal: true

class GameState

  #Getters
  attr_accessor :labyrinth, :players, :monsters, :currentPlayer, :winner, :log

  def initialize(labyrinth, players, monsters, currentPlayer, winner, log)
    @labyrinth = labyrinth
    @players = players
    @monsters = monsters
    @currentPlayer = currentPlayer
    @winner = winner
    @log = log
  end
end
