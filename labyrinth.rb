# frozen_string_literal: true

class Labyrinth
  BLOCK_CHAR = 'X'
  EMPTY_CHAR = '-'
  MONSTER_CHAR = 'M'
  COMBAT_CHAR = 'C'
  EXIT_CHAR = 'E'
  ROW = 0
  COL = 1

  attr_reader :nRows, :nCols

  def initialize(nRows, nCols, exitRow, exitCol)
    @nRows = nRows
    @nCols = nCols
    @exitRow = exitRow
    @exitCol = exitCol

    #Implementación de las clases "square"
    @monsters = Array.new(@nRows) { Array.new(@nCols) }
    @players = Array.new(@nRows) { Array.new(@nCols) }
    @labyrinth = Array.new(@nRows) { Array.new(@nCols) }
  end

  def spreadPlayers(players)
    #IMPLEMENTAR
  end

  def haveAWinner
    if @players[@exitRow][@exitCol] != nil
      true
    else
      false
    end
  end

  def to_s
    return "Labyrinth{ nRows= #{@nRows}, nCols= #{@nCols}, exitRow= #{@exitRow}, exitCol= #{@exitCol} }"
  end

  def addMonster(row, col, monster)
    if posOK(row, col) && emptyPos(row, col)
      @labyrinth[row][col] = 'M'
      monster.setPos(row, col)
    end
  end

  def putPlayer(direction, player)
    #IMPLEMENTAR
  end

  def addBlock(orientation, startRow, startCol, length)
    #IMPLEMENTAR
  end

  def validMoves(row, col)
    #IMPLEMENTAR
  end

  private #A partir de aquí todos los métodos son privados
  def posOK(row, col)
    if row < 0 || row >= @nRows || col < 0 || col >= @nCols
      false
    else
      true
    end
  end

  def emptyPos(row, col)
    if @labyrinth[row][col] == '-'
      true
    else
      false
    end
  end

  def monsterPos(row, col)
    if @labyrinth[row][col] == 'M'
      true
    else
      false
    end
  end

  def exitPos(row, col)
    if @labyrinth[row][col] == 'E'
      true
    else
      false
    end
  end

  def combatPos(row, col)
    if @labyrinth[row][col] == 'C'
      true
    else
      false
    end
  end

  def canStepOn(row, col)
    if posOK(row, col)
      if emptyPos(row, col) || monsterPos(row, col) || exitPos(row, col)
        true
      else
        false
      end
    else
      false
    end
  end

  def updateOldPos(row, col)
    if posOK(row, col)
      if @labyrinth[row][col] == 'C'
        @labyrinth[row][col] = 'M'
      else
        @labyrinth[row][col] = '-'
      end
    end
  end

  def dir2Pos(row, col, direction)
    case direction
      when :LEFT
        [row, col - 1]
      when :RIGHT
        [row, col + 1]
      when :UP
        [row-1, col]
      when :DOWN
        [row+1, col]
      else
        puts "Dirección inválida"
        [row, col] #No se mueve
      end
  end

  def randomEmptyPos
    @fila = Dice.randomPos(@nRows)
    @columna = Dice.randomPos(@nCols)

    while labyrinth[@fila][@columna] != '-'
      @fila = Dice.randomPos(@nRows)
      @columna = Dice.randomPos(@nCols)
    end

    [@fila, @columna]
  end

  def putPlayer2D(oldRow, oldCol, row, col, player)
    #Implementar
  end
end
