require_relative 'inputable'

class Participant
  attr_reader :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def total_points
    hand.reduce(0) do |total, card|
      if card.type == 'Ace'
        total + value_of_ace(total)
      else
        total + value_of(card)
      end
    end
  end

  def bust?
    total_points > 21
  end

  def value_of(card)
    return card.type      if card.type.is_a?(Integer)
    return value_of_ace   if card.type == 'Ace'
    10
  end

  def value_of_ace(total)
    return 1 if total + 11 > 21
    11
  end

  def show_hand
    output = ''
    hand.each { |card| output += " #{card} " }
    output
  end

  def ==(other_participant)
    total_points == other_participant.total_points
  end

  def <=>(other_participant)
    total_points <=> other_participant.total_points
  end

  def reset_hand
    hand.clear
  end
end

class Player < Participant
  include Inputable

  def initialize
    super(input_name)
  end

  def stay?
    answer = input_hit_or_stay
    answer == 's' || answer == 'stay'
  end
end

class Dealer < Participant
  def initialize
    super("The Dealer")
  end

  def stay?
    total_points > 17
  end

  def show_concealed_hand
    output = ''

    hand.each_with_index do |card, ind|
      output += (ind == 0 ? " { HIDDEN } " : " #{card} ")
    end

    output
  end
end
