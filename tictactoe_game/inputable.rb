module Inputable
  def get_name(player_num)
    name = ''

    puts "Player #{player_num}, What is your name?:"
    loop do
      name = gets.chomp
      break if valid_name?(name)
      system('clear')
      puts "Name must be at least 2 letters long and can ONLY contain letters"
      puts "Please enter another name:"
    end
    
    system('clear')
    name.capitalize
  end

  def get_marker(player_num)
    marker = ''

    puts "Player #{player_num}, What is your marker?:"
    loop do
      marker = gets.chomp
      break if valid_marker?(marker)
      system('clear')
      puts "A marker must be 1 character long and cannot be a space."
      puts "Please enter another marker:"
    end
    
    system('clear')
    marker.upcase
  end

  def valid_name?(name)
    !( name.match?(/[^a-z]/i) ) && name.size > 1
  end

  def valid_marker?(marker)
    marker.size == 1 && marker != ' '
  end

  def valid_coordinate?(coordinate)
    coordinate > 0 && coordinate < 4
  end

  def valid_yes_no?(answer)
    ['yes', 'no', 'n', 'y'].include?(answer)
  end

  def get_coordinate_for(row_col)
    selection = nil

    puts "Select a #{row_col} on the board:"
    loop do
      selection = gets.chomp.to_i
      break if valid_coordinate?(selection)
      puts "Please select a #{row_col} between 1 and 3."
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

    answer == "y" || answer == "yes"
  end
end