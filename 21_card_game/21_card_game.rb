class 21CardGame
  def initialize
    @deck = generate_deck
    @player = Player.new
    @dealer = Dealer.new
    @participants = [@player, @dealer]
  end

  def play
    welcome_message
    deck.deal_card_to(player, 2)
    deck.deal_card_to(dealer, 2)

    loop do # Player turn
      display_hands
      break if     player.bust?
      break unless player.hit?
      deck.deal_card_to(player)
    end

    loop do # Dealer turn
      
      display_hands
      break if     player.bust?
      break if     dealer.bust? 
      break unless dealer.hit?
      deck.deal_card_to(dealer)
    end

    reveal_dealers_hand
    player.display_hand 

    tie? ? display_tie : display_winner(winner) 
    goodbye_message
  end
end
