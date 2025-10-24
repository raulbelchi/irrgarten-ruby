# frozen_string_literal: true

class Game
  MAX_ROUNDS = 10

  def initialize(nPlayers)
    @currentPlayerIndex = 0
    @log = ""
    @monsters = []
    @players = []

    #Creamos los jugadores
    for i in 0...nPlayers
      @players.push(Player.new((i + 1), Dice.randomIntelligence, Dice.randomStrength))
    end

    #Creamos el laberinto, lo configuramos y repartimos los jugadores
    @labyrinth = Labyrinth.new(10, 10, 5, 5)
    configureLabyrinth
    #@labyrinth.spread_players(@players)
  end

  def finished
    @labyrinth.haveAWinner
  end

  def nextStep(preferredDirection)
    #IMPLEMENTAR
  end

  def getGameState
    GameState.new(@labyrinth.to_s, @players.to_s, @monsters.to_s, @currentPlayerIndex, finished, @log)
  end

  private #A partir de aquí todos los métodos son privados
  def configureLabyrinth
    #@labyrinth.addBlock(Orientation.HORIZONTAL, 0, 0, 10)

    #Añade monstruos al laberinto en posiciones aleatorias
    @monstruo1 = Monster.new("monstruo1", Dice.randomIntelligence, Dice.randomStrength)
    @monsters.push(@monstruo1)
    @labyrinth.addMonster(Dice.randomPos(@labyrinth.nRows), Dice.randomPos(@labyrinth.nCols), @monstruo1)

    @monstruo2 = Monster.new("monstruo2", Dice.randomIntelligence, Dice.randomStrength)
    @monsters.push(@monstruo2)
    @labyrinth.addMonster(Dice.randomPos(@labyrinth.nRows), Dice.randomPos(@labyrinth.nCols), @monstruo2)
  end

  def nextPlayer
    #Operador cíclico
    nextIndex = (@currentPlayerIndex + 1) % @players.size

    #Comprobamos que el jugador está vivo
    while @players[nextIndex].dead
      nextIndex = (nextIndex + 1) % @players.size
      #Si los demás jugadores están muertos, se queda el mismo
      if nextIndex == @currentPlayerIndex
        return
      end
    end

    #Actualizamos el jugador y el índice
    @currentPlayerIndex = nextIndex
    @currentPlayer = @players[@currentPlayerIndex]
  end

  def actualDirection(preferredDirection)
    #IMPLEMENTAR
  end

  def combat(monster)
    #IMPLEMENTAR
  end

  def manageReward(winner)
    #IMPLEMENTAR
  end

  def manageResurrection
    #IMPLEMENTAR
  end

  #logs
  def logPlayerWon
    @log += "El jugador ha ganado el combate.\n"
  end

  def logMonsterWon
    @log += "El monstruo ha ganado el combate.\n"
  end

  def logResurrected
    @log += "El jugador ha resucitado.\n"
  end

  def logPlayerSkipTurn
    @log += "El jugador ha perdido el turno por estar muerto.\n"
  end

  def logPlayerNoOrders
    @log += "No es posible realizar esa acción.\n"
  end

  def logNoMonster
    @log += "El jugador se ha desplazado a una celda vacía o no ha sido posible desplazarse.\n"
  end

  def logRounds(rounds, max)
    @log += "Se han producido #{rounds}/#{max} rondas de combate.\n"
  end

end
