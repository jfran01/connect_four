class Board
  attr_reader :board

  def initialize
    @board = Array.new(6) {Array.new(7)}
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

  def set_of_four
    true if four_in_a_column || four_in_a_row || four_in_a_diagonal
  end

  def four_in_a_column
    column_values = []
    4.times do |i|
      column_values.push(@board[@selected_row + i][@selected_column])
    end
    return false if column_values.any?(nil)

    column_values.uniq.size == 1 ? true : false
  end

  def four_in_a_row
    row_values = []
    8.times do |i|
      row_values.push(@board[@selected_row][@selected_column + i - 4])
    end
    return false if row_values.any?(nil)

    row_values.uniq.size == 1 ? true : false
  end

  def four_in_a_diagonal
    diagonal_values = []
    4.times do |i|
      diagonal_values.push(@board[@selected_row + i][@selected_column + i])
    end
    return false if diagonal_values.any?(nil)

    diagonal_values.uniq.size == 1 ? true : false
  end
end
