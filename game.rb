# frozen_string_literal: true

require_relative 'player'
require_relative 'dice'
require_relative 'labyrinth'
require_relative 'monster'
require_relative 'game_state'
require_relative 'orientation'
require_relative 'game_character'

module Irrgarten
  class Game
    MAX_ROUNDS = 10

    def initialize(nPlayers, debug)
      @current_player_index = 0
      @log = ""
      @monsters = []
      @players = []

      #Creamos los jugadores
      for i in 0...nPlayers
        @players.push(Player.new(i, Dice.random_intelligence, Dice.random_strength))
      end

      @current_player = @players[0]

      #Creamos el laberinto, lo configuramos y repartimos los jugadores
      @labyrinth = Labyrinth.new(10, 10, 5, 5)
        if(!debug)
          configure_labyrinth
        else
          configure_labyrinth_debug
        end
      @labyrinth.spread_players(@players)
    end

    def finished
      @labyrinth.have_a_winner
    end

    def next_step(preferred_direction)
      @log = ""
      dead = @current_player.dead

      if !dead
        direction = actual_direction(preferred_direction)

        if direction != preferred_direction
          log_player_no_orders
        end

        monster = @labyrinth.put_player(direction, @current_player)

        if monster == nil
          log_no_monster
        else
          winner = combat(monster)
          manage_reward(winner)
        end
      else
        manage_resurrection
      end

      end_game = finished

      if !end_game
        next_player
      end

      return end_game
    end

    def get_game_state
      GameState.new(@labyrinth.to_s, @players.to_s, @monsters.to_s, @current_player_index, finished, @log)
    end

    private #A partir de aquí todos los métodos son privados
    def configure_labyrinth
      @labyrinth.add_block(Orientation::VERTICAL, 1, 2, 3)
      @labyrinth.add_block(Orientation::HORIZONTAL, 3, 3, 4)
      @labyrinth.add_block(Orientation::VERTICAL, 4, 3, 4)
      @labyrinth.add_block(Orientation::VERTICAL, 3, 8, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 2, 5, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 8, 5, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 7, 2, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 6, 5, 1)

      #Añade monstruos al laberinto en posiciones aleatorias
      @monstruo1 = Monster.new("monstruo1", Dice.random_intelligence, Dice.random_strength)
      @monsters.push(@monstruo1)
      @labyrinth.add_monster(Dice.random_pos(@labyrinth.n_rows), Dice.random_pos(@labyrinth.n_cols), @monstruo1)

      @monstruo2 = Monster.new("monstruo2", Dice.random_intelligence, Dice.random_strength)
      @monsters.push(@monstruo2)
      @labyrinth.add_monster(Dice.random_pos(@labyrinth.n_rows), Dice.random_pos(@labyrinth.n_cols), @monstruo2)
    end

    def configure_labyrinth_debug
      @labyrinth.add_block(Orientation::VERTICAL, 1, 2, 3)
      @labyrinth.add_block(Orientation::HORIZONTAL, 3, 3, 4)
      @labyrinth.add_block(Orientation::VERTICAL, 4, 3, 4)
      @labyrinth.add_block(Orientation::VERTICAL, 3, 8, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 2, 5, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 8, 5, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 7, 2, 1)
      @labyrinth.add_block(Orientation::VERTICAL, 6, 5, 1)

      #Añade monstruos al laberinto
      @monstruo1 = Monster.new("monstruo1", 1000, 1000)
      @monsters.push(@monstruo1)
      @labyrinth.add_monster(5, 4, @monstruo1)

      @monstruo2 = Monster.new("monstruo2", 1000, 1000)
      @monsters.push(@monstruo2)
      @labyrinth.add_monster(5, 7, @monstruo2)
    end

    def next_player
      #Operador cíclico
      @current_player_index = (@current_player_index + 1) % @players.size
      @current_player = @players[@current_player_index]
    end

    def actual_direction(preferred_direction)
      current_row = @current_player.row
      current_col = @current_player.col

      valid_moves = @labyrinth.valid_moves(current_row, current_col)

      output = @current_player.move(preferred_direction, valid_moves)

      return output
    end

    def combat(monster)
      rounds = 0
      winner = GameCharacter::PLAYER
      player_attack = @current_player.attack
      lose = monster.defend(player_attack)

      while !lose && rounds < MAX_ROUNDS
        winner = GameCharacter::MONSTER
        rounds+=1
        monster_attack = monster.attack
        lose = @current_player.defend(monster_attack)

        if !lose
          player_attack = @current_player.attack
          winner = GameCharacter::PLAYER
          lose = monster.defend(player_attack)
        end
      end
      log_rounds(rounds, MAX_ROUNDS)
      return winner
    end

    def manage_reward(winner)
      if winner == GameCharacter::PLAYER
        @current_player.receive_reward
        log_player_won
      else
        log_monster_won
      end
    end

    def manage_resurrection
      resurrect = Dice.resurrect_player

      if resurrect
        @current_player.resurrect
        log_resurrected
      else
        log_player_skip_turn
      end
    end

    #logs
    def log_player_won
      @log += "El jugador ha ganado el combate.\n"
    end

    def log_monster_won
      @log += "El monstruo ha ganado el combate.\n"
    end

    def log_resurrected
      @log += "El jugador ha resucitado.\n"
    end

    def log_player_skip_turn
      @log += "El jugador ha perdido el turno por estar muerto.\n"
    end

    def log_player_no_orders
      @log += "No es posible realizar esa acción.\n"
    end

    def log_no_monster
      @log += "El jugador se ha desplazado a una celda vacía o no ha sido posible desplazarse.\n"
    end

    def log_rounds(rounds, max)
      @log += "Se han producido #{rounds}/#{max} rondas de combate.\n"
    end

  end
end