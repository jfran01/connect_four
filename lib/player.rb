class Player
  attr_reader :symbol

  def choose_symbol
    # unicode_symbols: ["\u2600", "\u2601", "\u2605", "\u2606", "\u2618", "\u263a", "\u263b", "\u263c", "\u263e", "\u2660", "\u2661", "\u2662", "\u2663", "\u2664", "\u2665", "\u2666", "\u2667"]
    colour_symbols = ["\e[30m\u2b24\e[0m", "\e[31m\u2b24\e[0m", "\e[32m\u2b24\e[0m", "\e[33m\u2b24\e[0m",
                      "\e[34m\u2b24\e[0m", "\e[35m\u2b24\e[0m", "\e[36m\u2b24\e[0m", "\e[37m\u2b24\e[0m"]
    available_symbols = colour_symbols
    puts 'Choose one of the following symbols (or enter your own):'
    available_symbols.each_with_index { |sym, i| puts "#{i + 1}: #{sym}" }
    choose_num = gets.chomp
    @symbol = if choose_num.to_i == 0 || !available_symbols[choose_num.to_i - 1]
                choose_num
              else
                available_symbols[choose_num.to_i - 1]
              end
  end

  def choose_column
    puts 'Choose which number column you would like to place your counter into:'
    gets.chomp.to_i - 1
  end
end
