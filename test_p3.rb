require_relative 'player'
require_relative 'dice'
require_relative 'weapon'
require_relative 'shield'

module Irrgarten
  @p1 = Player.new('0', Dice.random_intelligence, Dice.random_strength)
  puts(@p1.to_s)
  for i in 0..2
    @p1.receive_reward
    puts(@p1.to_s)
  end
end
