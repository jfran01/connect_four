require_relative 'player'
require_relative 'display'

class Game
  def initialize 
    @board_array = Array.new(42)
    @player_one = Player.new
    @player_two = Player.new
    @players = [@player_one, @player_two]
  end
end
