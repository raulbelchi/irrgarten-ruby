# frozen_string_literal: true

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

  def randomPos(max)
    return @@generator.rand(max)
  end

  def whoStarts(nplayers)
    return @@generator.rand(nplayers)
  end

  def randomIntelligence()
    return @@generator.rand(@@MAX_INTELLIGENCE)
  end

  def randomStrength()
    return @@generator.rand(@@MAX_STRENGTH)
  end

  def resurrectPlayer()
    return @@generator.rand() <= @@RESURRECT_PROB
  end

  def weaponsReward()
    return @@generator.rand(@@WEAPONS_REWARD)
  end

  def shieldsReward()
    return @@generator.rand(@@SHIELDS_REWARD)
  end

  def healthReward()
    return @@generator.rand(@@HEALTH_REWARD)
  end

  def weaponPower()
    return @@generator.rand(@@MAX_ATTACK)
  end

  def shieldPower()
    return @@generator.rand(@@MAX_SHIELD)
  end

  def usesLeft()
    return @@generator.rand(@@MAX_USES)
  end

  def intensity(competence)
    return @@generator.rand(competence)
  end

  def discardElement(usesLeft)
    if(usesLeft == @@MAX_USES)
      return false
    elsif(usesLeft == 0)
      return true
    else
      return @@generator.rand(@@MAX_USES) >= usesLeft;
    end
  end
end