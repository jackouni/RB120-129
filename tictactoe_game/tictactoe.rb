## TTT Game

class TTTGame

  def initialize
    @board = Board.new
    @player1 = Player.new
  end

  def play
    welcome_message
    
    loop do
      puts board
      break if board.is_full?
      
      player1.take_turn
      break if board.winning_line?
      
      player2.take_turn
      break if board.winning_line?
    end

    display_results
    goodbye
  end
end