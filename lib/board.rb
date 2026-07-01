# frozen_string_literal: true

require_relative 'renderer'

class Board
  attr_reader :board

  include Render

  def initialize
    @board = Array.new(6) { Array.new(7) }
  end

  def check_player_choice(chosen_column, symbol)
    unless chosen_column.between?(0, 6)
      puts 'This column does not appear on the board. Please enter a different column between 1-7:'
      return false
    end
    @board.reverse_each.with_index do |row, index|
      if row[chosen_column].nil?
        row[chosen_column] = symbol
        @selected_row = -index - 1
        @selected_column = chosen_column
        return true
      end
    end
    puts "It appears that column #{chosen_column} is full. Please enter a different column between 1-7:"
    false
  end

  def four_in_a_row(symbol)
    directions = [[0, 1], [1, 0], [1, 1], [-1, 1]]
    directions.each do |dir|
      @count = 1
      @count += check_direction(dir[0], dir[1], symbol)
      @count += check_direction(-dir[0], -dir[1], symbol)
      return true if @count == 4
    end
    false
  end

  def check_direction(dr, dc, symbol)
    count = 0
    r = @selected_row + dr
    c = @selected_column + dc
    while r.between?(0, @board.length - 1) && c.between?(0, @board.length - 1) && @board[r][c] == symbol
      count += 1
      r += dr
      c += dc
    end
    count
  end
end
