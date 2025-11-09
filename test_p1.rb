# frozen_string_literal: true
#
require_relative 'weapon'
require_relative 'shield'

module Irrgarten
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


    puts("Prueba shields_reward")
    for i in (0..10)
      puts(Dice.shields_reward)
    end

    puts("Prueba health_reward")
    for i in (0..10)
      puts(Dice.health_reward)
    end

    puts("Prueba resurrect_player")
    for i in (0..10)
      puts(Dice.resurrect_player)
    end

    puts("Prueba discard_element")
    for i in (0..10)
      puts(Dice.discard_element(3))
    end

    puts("Prueba random_strength")
    for i in (0..10)
      puts(Dice.random_strength)
    end

  end
end