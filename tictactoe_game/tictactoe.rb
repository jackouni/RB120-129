require_relative 'board'
require_relative 'player'
require_relative 'inputable'
require_relative 'displayable'
require_relative 'clearable'

class TTTGame
  include Inputable
  include Displayable
  include Clearable

  def initialize
    clear_display
    @round   = 1
    @board   = generate_new_board
    @players = generate_new_players
    @player1, @player2 = @players
    @current_player = @players.sample
  end

  def play
    welcome_message

    loop do
      loop do
        current_player.place_marker(board)
        display_header
        puts board
        break if board.someone_won? || board.full?
        alternate_player_turn
      end

      if board.someone_won?
        display_winner(winning_player)
      else
        display_tie
      end

      break unless continue_playing?
      board.reset
      self.round = round + 1
      current_player.increment_score
    end

    goodbye_message
  end

  private

  attr_accessor :player1, :player2, :board, :current_player, :players, :round

  def generate_new_board
    dimensions = user_inputs_board_dimensions
    Board.new(dimensions)
  end

  def generate_new_players
    player1_name   = user_inputs_name(1)
    player1_marker = user_inputs_marker(1)
    player1        = Human.new(player1_name, player1_marker)

    if human_vs_computer?
      [player1, generate_computer_player(player1)]
    else
      [player1, generate_another_player(player1)]
    end
  end

  def generate_another_player(player1)
    player2_name   = nil
    player2_marker = nil

    loop do
      player2_name = user_inputs_name(2)
      break unless player1.name == player2_name
      puts "Sorry, that name is already taken!"
      puts "Please, try a different name:"
    end

    loop do
      player2_marker = user_inputs_marker(2)
      break unless player1.marker == player2_marker
      puts "That marker was taken by #{player1.name}!"
      puts "Please, select a different marker:"
    end

    Human.new(player2_name, player2_marker)
  end

  def generate_computer_player(player1)
    clear_display
    remaining_letter_markers = ('A'..'Z').to_a - [player1.marker]
    computer_marker = remaining_letter_markers.sample
    computer_name = (player1.name == "Computer" ? "R2D2" : "Computer")
    Computer.new(computer_name, computer_marker)
  end

  def winning_player
    winning_line = board.winning_line
    return nil unless winning_line
    winning_marker = winning_line.first.marking
    player1.marker == winning_marker ? player1 : player2
  end

  def alternate_player_turn
    self.current_player = (players - [current_player]).sample
  end
end

game = TTTGame.new
game.play
