class Board 
  attr_reader :board
  def initialize
    @board = Array.new(6, Array.new(7))
  end
  def check_player_choice (chosen_column, symbol) 
    if !chosen_column.between?(0, 6) 
      puts "This column does not appear on the board. Please enter a different column between 1-7:"
      return false
    end 
    @board.reverse_each do |row|
      if row[chosen_column].nil? 
        row[chosen_column] = symbol
        return true
      end
    end
    puts "It appears that column #{chosen_column} is full. Please enter a different column between 1-7:"
    return false
  end
end