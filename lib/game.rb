# frozen_string_literal: true

require_relative 'player'
require_relative 'board'

class Game
  attr_reader :current_player

  def initialize
    @board = Board.new
    @player_one = Player.new(1)
    @player_two = Player.new(2)
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
    loop do
      play_round
      break if check_for_winner
      break if check_for_draw

      change_player
    end
  end

  def play_round
    @board.print_board(@board.board)
    chosen_column = @current_player.choose_column
    @board.check_player_choice(chosen_column, @current_player.symbol)
  end

  def check_for_winner
    return unless @board.four_in_a_row(@current_player.symbol)

    @board.print_board(@board.board)
    puts "Hurrah! Player #{@current_player.id} won! Better luck next time Player #{@players[1].id}"
    true
  end

  def check_for_draw
    return unless @board.board.any?(nil) && !@board.four_in_a_row(@current_player.symbol)

    @board.print_board(@board.board)
    puts "It's a draw! Good game- it appears you have each met your match."
    true
  end
end

game = Game.new
game.play_game
