require_relative 'player'
require_relative 'board'

class Game
  attr_reader :board_array, :current_player
  def initialize 
    # @board_array = Array.new(6, Array.new(7))
    @board = Board.new
    @player_one = Player.new
    @player_two = Player.new
    @players = [@player_one, @player_two]
    @current_player = @players[0]
  end
  def change_player
    @players.rotate!
    @current_player = @players[0]
  end
  def play_game
    @player_one.choose_symbol
    @player_two.choose_symbol
    play_round until check_for_winner || check_for_draw
  end
  def play_round
    @current_player.make_choice
  end
  def check_for_winner
    if @board.four_in_a_row 
      puts "Hurrah! #{@current_player} won! Better luck next time #{@players[1]}"
      true
    end
  end
  def check_for_draw
    if @board.board_array.all && !@board.four_in_a_row
      puts "It's a draw! Good game- it appears you have each met your match."
      true
    end
  end
end
