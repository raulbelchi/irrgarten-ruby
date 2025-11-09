# frozen_string_literal: true

module Irrgarten
  class Labyrinth
    BLOCK_CHAR = 'X'
    EMPTY_CHAR = '-'
    MONSTER_CHAR = 'M'
    COMBAT_CHAR = 'C'
    EXIT_CHAR = 'E'
    ROW = 0
    COL = 1

    attr_reader :n_rows, :n_cols

    def initialize(n_rows, n_cols, exit_row, exit_col)
      @n_rows = n_rows
      @n_cols = n_cols
      @exit_row = exit_row
      @exit_col = exit_col

      #Implementación de las clases "square"
      @monsters = Array.new(@n_rows) { Array.new(@n_cols) }
      @players = Array.new(@n_rows) { Array.new(@n_cols) }
      @labyrinth = Array.new(@n_rows) { Array.new(@n_cols) }

      #Rellenamos el laberinto con carácteres vacíos y los muros exteriores
      @n_rows.times do |i|
        @n_cols.times do |j|
          if i == @exit_row && j == @exit_col
            @labyrinth[i][j] = EXIT_CHAR
          elsif i == 0 || i == (@n_rows - 1) || j == 0 || j == (@n_cols - 1)
            @labyrinth[i][j] = BLOCK_CHAR
          else
            @labyrinth[i][j] = EMPTY_CHAR
          end
        end
      end
    end

    def spread_players(players)
      players.each do |p|
        pos = random_empty_pos
        put_player_2D(-1, -1, pos[ROW], pos[COL], p)
      end
    end

    def have_a_winner
      if @players[@exit_row][@exit_col] != nil
        true
      else
        false
      end
    end

    def to_s
      laberinto = ""

      @n_rows.times do |i|
        @n_cols.times do |j|
          laberinto += "#{@labyrinth[i][j]} "
        end
        laberinto += "\n"; #Salto de línea al final de cada fila
      end

      return laberinto
    end

    def add_monster(row, col, monster)
      if pos_OK(row, col) && empty_pos(row, col)
        @labyrinth[row][col] = 'M'
        @monsters[row][col] = monster
        monster.set_pos(row, col)
      end
    end

    def put_player(direction, player)
      old_row = player.row
      old_col = player.col

      newPos = dir_2_pos(old_row, old_col, direction)
      monster = put_player_2D(old_row, old_col, newPos[ROW], newPos[COL], player)

      return monster
    end

    def add_block(orientation, start_row, start_col, length)
      if orientation == Orientation::VERTICAL
        inc_row = 1
        inc_col = 0
      else
        inc_row = 0
        inc_col = 1
      end

      row = start_row
      col = start_col

      while pos_OK(row, col) && empty_pos(row, col) && length>0
        @labyrinth[row][col] = BLOCK_CHAR

        length -= 1
        row += inc_row
        col += inc_col
      end
    end

    def valid_moves(row, col)
      output = []

      if can_step_on(row+1, col)
        output.push(Directions::DOWN)
      end
      if can_step_on(row-1, col)
        output.push(Directions::UP)
      end
      if can_step_on(row, col+1)
        output.push(Directions::RIGHT)
      end
      if can_step_on(row, col-1)
        output.push(Directions::LEFT)
      end

      return output
    end

    private #A partir de aquí todos los métodos son privados
    def pos_OK(row, col)
      if row < 0 || row >= @n_rows || col < 0 || col >= @n_cols
        false
      else
        true
      end
    end

    def empty_pos(row, col)
      if @labyrinth[row][col] == '-'
        true
      else
        false
      end
    end

    def monster_pos(row, col)
      if @labyrinth[row][col] == 'M'
        true
      else
        false
      end
    end

    def exit_pos(row, col)
      if @labyrinth[row][col] == 'E'
        true
      else
        false
      end
    end

    def combat_pos(row, col)
      if @labyrinth[row][col] == 'C'
        true
      else
        false
      end
    end

    def can_step_on(row, col)
      if pos_OK(row, col)
        if empty_pos(row, col) || monster_pos(row, col) || exit_pos(row, col)
          true
        else
          false
        end
      else
        false
      end
    end

    def update_old_pos(row, col)
      if pos_OK(row, col)
        if @labyrinth[row][col] == 'C'
          @labyrinth[row][col] = 'M'
        else
          @labyrinth[row][col] = '-'
        end
      end
    end

    def dir_2_pos(row, col, direction)
      case direction
        when :left
          [row, col - 1]
        when :right
          [row, col + 1]
        when :up
          [row-1, col]
        when :down
          [row+1, col]
        else
          puts "Dirección inválida"
          [row, col] #No se mueve
        end
    end

    def random_empty_pos
      fila = Dice.random_pos(@n_rows)
      columna = Dice.random_pos(@n_cols)

      while @labyrinth[fila][columna] != '-'
        fila = Dice.random_pos(@n_rows)
        columna = Dice.random_pos(@n_cols)
      end

      [fila, columna]
    end

    def put_player_2D(old_row, old_col, row, col, player)
      output = nil

      if can_step_on(row, col)

        if pos_OK(old_row, old_col)
          p = @players[old_row][old_col]

          if p == player
            update_old_pos(old_row, old_col)
            @players[old_row][old_col] = nil
          end
        end
        monster_pos = monster_pos(row, col)

        if monster_pos
          @labyrinth[row][col] = COMBAT_CHAR
          output = @monsters[row][col]
        else
          number = player.number
          @labyrinth[row][col] = number
        end
        @players[row][col] = player
        player.set_pos(row, col)
      end

      return output
    end

  end
end