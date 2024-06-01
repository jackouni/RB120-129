module Inputable
  VALID_TURNS   = ['hit', 'stay', 'h', 's']
  VALID_YES_NOS = ['n', 'no', 'y', 'yes']

  def input_hit_or_stay
    answer = ''

    puts "Would you like to hit or stay?"

    loop do
      puts "Type \"hit\" (or \"h\") \"stay\" (or \"s\"):"
      answer = gets.chomp.downcase
      break if valid_turn?(answer)
      puts "Please give a valid answer!"
    end

    answer
  end

  def valid_turn?(answer)
    VALID_TURNS.include?(answer)
  end

  def input_name
    name = ''

    puts "What is your name?"

    loop do
      name = gets.chomp.capitalize
      break if valid_name?(name)
      puts "Please enter a valid name!"
      puts "Only letters please (no numbers, spaces or other characters)"
    end

    name
  end

  def valid_name?(name)
    !name.match?(/[^a-z]/i)
  end

  def input_play_again
    answer = ''

    puts "Would you like to play again?"
    loop do
      puts "Enter 'y' or 'n':"
      answer = gets.chomp.downcase
      break if valid_yes_no?(answer)
      puts "Please enter a valid answer!"
    end

    answer
  end

  def valid_yes_no?(answer)
    VALID_YES_NOS.include?(answer)
  end
end
