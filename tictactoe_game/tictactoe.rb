require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'inputable.rb'
require_relative 'displayable.rb'

class TTTGame
  include Inputable
  include Displayable

  attr_reader :display, :player1, :player2, :board, :current_player, :players

  def initialize
    clear_display
    @board = generate_new_board 
    @players = generate_new_players
    @player1, @player2 = @players
    @current_player = @player1
  end

  def play
    welcome_message

    loop do
      loop do
        current_player.place_marker(board)
        puts board
        break if board.someone_won? || board.full?
        alternate_player
      end

      if board.someone_won?  
        display_winner(winning_player)
      else 
        display_tie
      end

      break unless continue_playing?
      reset_game
    end

    goodbye_message
  end

  def generate_new_board
    dimensions = get_users_board_dimensions
    Board.new(dimensions)
  end

  def generate_new_players
    player1_name   = get_users_name(1)
    player1_marker = get_users_marker(1)

    if human_vs_computer?
      system('clear')
      computer_marker = ( ('A'..'Z').to_a - [player1_marker] ).sample
      [Human.new(player1_name, player1_marker), Computer.new("Computer", computer_marker)]

    else
      player2_name   = nil
      player2_marker = nil

      loop do
        player2_name = get_users_name(2)
        break unless player1_name == player2_name
        puts "Sorry, that name is already taken! Please, try a different name:"
      end

      loop do
        player2_marker = get_users_marker(2)
        break unless player1_marker == player2_marker
        puts "Sorry, that marker was taken by #{player1_name}! Please, select a different marker:"
      end

      [Human.new(player1_name, player1_marker), Human.new(player2_name, player2_marker)]
    end
  end

  def winning_player
    winning_line = board.winning_line
    return nil unless winning_line
    winning_marker = winning_line.first.marking
    player1.marker == winning_marker ? player1 : player2
  end

  def alternate_player
    @current_player = (players - [current_player]).sample
  end

  def reset_game
    @board = generate_new_board
    @players = generate_new_players
    @player1, @player2 = @players
    @current_player = @player1
  end
end

game = TTTGame.new
game.play
