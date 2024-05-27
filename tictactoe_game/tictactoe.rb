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
      update_board_with(player1.tile_placement)
      display.board_status
      
      break if board.winning_line
      
      update_board_with(player2.tile_placement)
      display.board_status

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