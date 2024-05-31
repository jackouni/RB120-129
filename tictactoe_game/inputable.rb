require_relative "clearable"

module Inputable
  def user_inputs_name(player_num, other_player=nil)
    name = ''

    puts "Player #{player_num}, What is your name?:"
    loop do
      name = gets.chomp.capitalize
      break if valid_name?(name)
      if other_player
        break if other_player.same_name?(name)
      end

      clear_display
      puts "Name must be at least 2 letters long and can ONLY contain letters"
      puts "Please enter another name:"
    end

    clear_display
    name
  end

  def user_inputs_marker(player_num)
    marker = ''

    puts "Player #{player_num}, What is your marker?:"
    loop do
      marker = gets.chomp
      break if valid_marker?(marker)
      clear_display
      puts "A marker must be 1 character long and cannot be a space."
      puts "Please enter another marker:"
    end

    clear_display
    marker.upcase
  end

  def valid_name?(name)
    !(name.match?(/[^a-z]/i)) && name.size > 1
  end

  def valid_marker?(marker)
    marker.size == 1 && marker != ' '
  end

  def valid_coordinate?(coordinate, dimensions)
    coordinate > 0 && coordinate <= dimensions
  end

  def valid_yes_no?(answer)
    ['yes', 'no', 'n', 'y'].include?(answer)
  end

  def input_coordinate_for(row_col, dimensions)
    selection = nil

    puts "Select a #{row_col} on the board:"
    loop do
      selection = gets.chomp.to_i
      break if valid_coordinate?(selection, dimensions)
      puts "Please select a #{row_col} from 1 to #{dimensions}."
    end

    selection
  end

  def human_vs_computer?
    puts "Would you like to play against a computer player?"
    answer = ''

    loop do
      puts "Answer either with 'yes' or 'no':"
      answer = gets.chomp.downcase
      break if valid_yes_no?(answer)
      puts "Please enter a valid input!"
    end

    clear_display
    answer == "y" || answer == "yes"
  end

  def valid_dimension?(dimension)
    dimension.to_i > 0 && dimension.to_i < 6
  end

  def user_inputs_board_dimensions
    dimension = ''

    puts "What dimension would you like for the square board for the game?"
    loop do
      puts "Please enter a valid number that is greater than 0 and less than 6:"
      dimension = gets.chomp
      break if valid_dimension?(dimension)
    end

    clear_display
    dimension.to_i
  end

  def continue_playing?
    puts "Would you like to play again?"
    answer = ''

    loop do
      puts "Answer either with 'yes' or 'no':"
      answer = gets.chomp.downcase
      break if valid_yes_no?(answer)
      puts "Please enter a valid input!"
    end

    clear_display
    answer == 'y' || answer == 'yes'
  end
end
