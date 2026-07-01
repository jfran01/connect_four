module Render
  def print_board (board)
    puts " 1  2  3  4  5  6  7 "
    board.dup.each do |row|
      puts "|" + row.map{|cell| (cell || " ").to_s}.join("||") + "|"
      puts "---------------------"
    end
  end
end