## TTT Game

module GameDisplays
  def welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "-----------------------"
    sleep(2)
    system('clear')
  end

  def display_results(winner)
    if winner == "Tie"
      puts "No one wins. Tie game."
    else
      puts "#{winner.name} won!"
    end
  end

  def goodbye
    puts "Good game! Goodbye now."
  end
end

class TTTGame
  attr_reader :board, :player1, :player2
  include GameDisplays

  def initialize
    welcome_message
    @board   = Board.new

    @player1 = Player.new
    @player2 = Player.new(@player1)
  end

  def play
    
    loop do
      break if board.is_full?
      
      board.status

      player1.place_marker(board)
      break if board.winning_line

      board.status

      player2.place_marker(board)
      break if board.winning_line
      system('clear')
      board.status
    end

    system('clear')
    board.status
    display_results(game_results)
    goodbye
  end

  def game_results
    winning_line   = board.winning_line

    winning_mark   = ''
    winning_mark   = winning_line.sample.marking unless winning_line == nil
    winning_player = 'No one'

    winning_player = player1 if player1.marker == winning_mark
    winning_player = player2 if player2.marker == winning_mark
    winning_player
  end
end

class Player
  attr_reader :name, :marker

  def initialize(other_player=nil)
    @name   = Player.choose_name(other_player)
    @marker = Player.choose_marker(other_player)
  end

  def self.choose_name(other_player)
    case other_player
    when nil then puts "Player 1, what's your name?"
    else          puts "Player 2, what's your name?"
    end

    name = ''

    loop do # Get Player's name
      name = gets.chomp

      if other_player && name.capitalize == other_player.name
        puts "Sorry, the name '#{name}' was taken by the other player."
        next
      end 
      
      unless name.size > 1 && name.match?(/[0-9a-z]/i) 
        puts "Stop messing around and enter a valid name..."
        puts "A valid name being: A name with at least 2 characters and includes letters and/or numbers in it"
        next
      end

      break
    end

    name.capitalize
  end

  def self.choose_marker(other_player)
    case other_player
    when nil then puts "Player 1, what's your marker?"
    else          puts "Player 2, what's your marker?"
    end

    marker = ''

    loop do # Get Player's marker
      marker = gets.chomp

      if other_player && marker.upcase == other_player.marker
        puts "Sorry, the marker '#{marker}' was taken by the #{other_player.name}."
        next
      end 
      
      unless (marker.match?(/[a-z]/i) && marker.size == 1)
        puts "Marker must be a single letter. Please try again."
        next
      end

      system('clear')
      break
    end

    marker.upcase
  end

  def get_user_coordinate
    input = ''

    loop do
      input = gets.chomp
      break if valid_row_col?(input)
      system('clear')
      puts "Please enter a valid number (1, 2 or 3)!!"
    end

    input.to_i
  end

  def place_marker(board)
    row = nil
    col = nil
    square = nil

    loop do
      puts "#{name}, choose row placement:"
      row = get_user_coordinate
      
      puts "#{name}, choose column placement:"
      col = get_user_coordinate

      square = board.squares[row-1][col-1]
      break if square.unoccupied?
      
      puts "Sorry, that square is occupied. Please make another selection!"
    end

    square.marking = marker
  end

  def valid_row_col?(input)
    return false unless input.to_i.to_s == input
    return false unless input.to_i > 0 && input.to_i < 4
    true 
  end
end

class Board
  attr_accessor :squares

  def initialize
    @squares = Array.new(3) { Array.new(3) { Square.new } } 
  end

  def status
    system('clear')
    puts "\n"
    puts "      1   2   3   Column"
    
    squares.each_with_index do |row, r_ind|
      puts "    +---+---+---+" if r_ind == 0
      print " #{r_ind+1}  "
      
      row.each_with_index do |square, s_ind|
        if s_ind == 1
          print " #{square} "
        else
          print "| #{square} |"
        end
      end

      puts "\n"
      puts "Row +---+---+---+" if r_ind == 2
    end
  end

  def is_full?
    squares.all? do |row|
      row.all? { |square| square.occupied? }
    end
  end

  def horizontal_lines
    squares
  end

  def vertical_lines
    vertical_lines = []

    3.times do |col_ind|
      vertical_line = squares.inject([]) { |line, row| line << row[col_ind] }
      vertical_lines << vertical_line
    end

    vertical_lines
  end

  def top_left_diagonal_line
    squares.map.with_index { |row, ind| row[ind] }
  end

  def top_right_diagonal_line
    reversed_squares = squares.map(&:reverse)
    reversed_squares.map.with_index { |row, ind| row[ind] }
  end

  def winning_line
    diagonal_lines = [top_left_diagonal_line, top_right_diagonal_line]
    all_lines = [vertical_lines, horizontal_lines, diagonal_lines]
    all_lines = all_lines.flatten(1)

    line_win = all_lines.select do |line|
                comparison_square = line.first
                line.all?(comparison_square)
              end
    
    line_win.empty? ? nil : line_win.flatten
  end
end

class Square
  attr_accessor :marking

  def to_s
    marking == nil ? "*" : marking
  end

  def occupied?
    marking != nil
  end

  def unoccupied?
    marking == nil
  end

  def ==(other_square)
    marking == other_square.marking && other_square.occupied?
  end
end

game = TTTGame.new
game.play