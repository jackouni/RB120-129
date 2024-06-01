require_relative 'deck'
require_relative 'participant'
require_relative 'displayable'

class TwentyOneGame
  include Displayable
  include Inputable

  def initialize
    clear_display
    @deck   = Deck.new
    @player = Player.new
    @dealer = Dealer.new
    @participants = [@player, @dealer]
  end

  def play
    welcome_message
    
    loop do
      deal_initial_cards
      show_hands

      participants_take_turns

      show_revealed_hands
      display_bust_message if any_busts?
      tie? ? display_tie : display_winner(winner)

      play_again? ? reset_game : break
    end

    goodbye_message
  end

  private

  attr_reader :player, :dealer, :deck, :participants

  def tie?
    player == dealer
  end

  def winner
    return player if dealer.bust?
    return dealer if player.bust?
    participants.max
  end

  def deal_initial_cards
    2.times { deck.deal_a_card_to(player) }
    2.times { deck.deal_a_card_to(dealer) }
  end

  def take_turn(participant)
    loop do
      break if any_busts? || participant.stay?
      deck.deal_a_card_to(participant)
      show_hands if participant.is_a?(Player)
    end
  end

  def participants_take_turns
    participants.each { |participant| take_turn(participant) }
  end

  def any_busts?
    participants.any?(&:bust?)
  end

  def play_again?
    answer = input_play_again
    answer == 'y' || answer == 'yes'
  end

  def reset_game
    @deck = Deck.new
    participants.each(&:reset_hand)
  end
end

game = TwentyOneGame.new
game.play
