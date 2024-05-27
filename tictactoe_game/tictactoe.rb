require_relative 'board.rb'


class TTTDisplay
  def display_welcome_message
    puts "Welcome to Jack's OOP Tic Tac Toe!"
    puts "----------------------------------"
  end
end

class TTTGame
  def initialize
    @board   = Board.new 

    @player1 = Player.new
    @player2 = Player.new
    @players = [@player1, @player2]
    
    @display = TTTDisplay.new(@board) 
    @winner  = nil
  end

  def play
    display.welcome_message

    loop do
      player1.place_marker(board)
      puts board
      
      break if board.winning_line
      
      player2.place_marker(board)
      puts board

      break if board.full?
      break if board.winning_line?
    end 

    @winner = evaluate_winner(board.winning_line)

    if @winner == nil
      display.tie_message
    else
      display.winning_message(@winner)
    end

    display.goodbye_message
  end
end

