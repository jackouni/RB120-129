require_relative 'deck'
require_relative 'participant'
require_relative 'displayable'

class CardGame
  include Displayable
  attr_reader :player, :dealer, :deck
  def initialize
    @deck   = Deck.new
    @player = Player.new('Jack')
    @dealer = Dealer.new('The Dealer')
    @participants = [@player, @dealer]
  end

  def play
    welcome_message
    2.times { deck.deal_card_to(player) }
    2.times { deck.deal_card_to(dealer) }

    loop do # Player turn
      display_hands
      break if     player.bust?
      break unless player.hit?
      deck.deal_card_to(player)
    end

    loop do # Dealer turn
      break if     player.bust? || dealer.bust? 
      break unless dealer.hit?
      deck.deal_card_to(dealer)
    end

    display_revealed_hands
    tie? ? display_tie : display_winner(winner) 
    goodbye_message
  end

  def tie?
    player == dealer
  end

  def winner
    return player if dealer.bust?
    return dealer if player.bust?
    player > dealer ? player : dealer
  end
end

game = CardGame.new
game.play