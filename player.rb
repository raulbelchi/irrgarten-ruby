# frozen_string_literal: true

class Player
  MAX_WEAPONS = 2
  MAX_SHIELDS = 3
  INITIAL_HEALTH = 10
  HITS2LOSE = 3

  #getters
  attr_reader :row, :col, :number

  def initialize(number, intelligence, strength)
    @number = number
    @name = "Player ##{@number}"
    @intelligence = intelligence
    @strength = strength
    @health = INITIAL_HEALTH
    @consecutiveHits = 0
    @weapons = []
    @shields = []
  end

  def resurrect
    @weapons.clear
    @shields.clear
    @health = INITIAL_HEALTH
    @consecutiveHits = 0
  end

  def setPos(row, col)
    @row = row
    @col = col
  end

  def dead
    return @health <=0
  end

  def move(direction, validMoves)
    #IMPLEMENTAR
  end

  def attack
    return @strength + sumWeapons
  end

  def deffend(receivedAttack)
    return manageHit(receivedAttack)
  end

  def receiveReward
    #IMPLEMENTAR
  end

  def to_s
    return "Player{ name= #{@name}, number= #{@number}, intelligence= #{@intelligence}, strength= #{@strength}, health= #{@health}, row= #{@row}, col= #{@col}, consecutiveHits= #{@consecutiveHits} }"
  end

  private #A partir de aquí los métodos son privados
  def receiveWeapon(w)
    #IMPLEMENTAR
  end

  def receiveShield(s)
    #IMPLEMENTAR
  end

  def newWeapon
    return Weapon.new(Dice.weaponPower, Dice.usesLeft)
  end

  def newShield
    return Shield.new(Dice.shieldPower, Dice.usesLeft)
  end

  def sumWeapons
    @total = 0
    @weapons.each do |w|
      @total += w.attack
    end
    return @total
  end

  def sumShields
    @total = 0
    @shields.each do |s|
      @total += s.protect
    end
    return @total
  end

  def defensiveEnergy
    return @intelligence + sumShields
  end

  def manageHit(receivedAttack)
    #IMPLEMENTAR
  end

  def resetHits
    @consecutiveHits = 0
  end

  def gotWounded
    @health -= 1
  end

  def incConsecutiveHits
     @consecutiveHits += 1
  end

end
