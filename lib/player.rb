
class Player 
  attr_reader :symbol
  def choose_symbol
    available_symbols = ["\u2600", "\u2601", "\u2605", "\u2606", "\u2618", "\u263a", "\u263b", "\u263c", "\u263e", "\u2660", "\u2661", "\u2662", "\u2663", "\u2664", "\u2665", "\u2666", "\u2667"]
    puts "Choose one of the following symbols (or enter your own):"
    available_symbols.each_with_index {|sym, i| puts "#{i+1}: #{sym}"}
    choose_num = gets.chomp.to_i
    if choose_num == 0 || !available_symbols[choose_num - 1]
      @symbol = choose_num
    else
      @symbol = available_symbols[choose_num - 1]
    end
  end
end