# frozen_string_literal: true

class Monster
  INITIAL_HEALTH = 5

  def initialize(name, intelligence, strength)
    @name = name
    @intelligence = intelligence
    @strength = strength
    @health = INITIAL_HEALTH
    @row = -1
    @col = -1
  end

  def dead
    return @health<=0
  end

  def attack
    Dice.intensity(@strength)
  end

  def defend(receivedAttack)
    #IMPLEMENTAR
  end
  def setPos(row, col)
    @row = row
    @col = col
  end

  def to_s
    return "Monster{ name= #{@name}, intelligence= #{@intelligence}, strength= #{@strength}, health= #{@health}, row= #{@row}, col= #{@col} }"
  end

  private
  def gotWounded
    @health -= 1
  end
end
