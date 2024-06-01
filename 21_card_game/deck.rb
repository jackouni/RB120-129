class Deck
  SUITES     = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  CARD_TYPES = ['King', 'Ace', 'Queen', 'Jack'] + (2..10).to_a

  attr_reader :stack

  def initialize
    @stack = []

    SUITES.each do |suite|
      CARD_TYPES.each { |type| @stack << Card.new(suite, type) }
    end

    @stack.shuffle!
  end

  def deal_a_card_to(participant)
    participant.hand << stack.pop
  end
end

class Card
  attr_reader :type, :suite

  def initialize(suite, type)
    @type  = type
    @suite = suite
  end

  def to_s
    "{ #{type} of #{suite} }"
  end
end
