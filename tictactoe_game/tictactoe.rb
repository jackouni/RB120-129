## TTT Game

module GameDisplays
  def welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts "-----------------------"
  end
end


class TTTGame
  attr_reader :board, :player1, :player2

  include GameDisplays
  
  def initialize
    @board   = Board.new

    @player1 = Player.new
    @player2 = Player.new(@player1)
  end

  def play
    welcome_message
    
    loop do
      puts board
      break if board.is_full?
      
      player1_move = player1.place_marker
      board.update(player1_move)
      break if board.winning_line?
      
      player2_move = player2.place_marker
      board.update(player2_move)
      break if board.winning_line?
    end

    display_results
    goodbye
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
      
      unless name.size > 2 && name.match?(/[0-9a-z]/i) 
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
      
      unless marker.match?(/[a-z]/i) && marker.size == 1
        puts "Marker must be a single letter. Please try again."
        next
      end

      break
    end

    marker.upcase
  end
end

class Board
  attr_accessor :squares

  def initialize
    @squares = Array.new(3) { Array.new(3) { Square.new } } 
  end

  def to_s
    squares.each do |row|
      row.each { |square| print "| #{square} |" }
      puts ""
    end
  end
end

class Square
  attr_reader :mark

  def to_s
    mark == nil ? "*" : mark
  end
end

game = TTTGame.new
game.play