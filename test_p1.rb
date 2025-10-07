# frozen_string_literal: true
#
require_relative 'weapon'
require_relative 'shield'

class TestP1

  w1 = Weapon.new(1, 5)
  puts(w1.to_s)
  w2 = Weapon.new(3, 3)
  puts(w2.to_s)
  w3 = Weapon.new(2, 4)
  puts(w3.to_s)

  s1 = Shield.new(2, 3)
  puts(s1.to_s)
  s2 = Shield.new(1, 5)
  puts(s2.to_s)
  s3 = Shield.new(2, 4)
  puts(s3.to_s)

  DICE = Dice.new

  puts("Prueba shieldsReward")
  for i in (0..10)
    puts(DICE.shieldsReward())
  end

  puts("Prueba healthReward")
  for i in (0..10)
    puts(DICE.healthReward())
  end

  puts("Prueba resurrectPlayer")
  for i in (0..10)
    puts(DICE.resurrectPlayer())
  end

  puts("Prueba discardElement")
  for i in (0..10)
    puts(DICE.discardElement(3))
  end

  puts("Prueba randomStrength")
  for i in (0..10)
    puts(DICE.randomStrength())
  end

end
