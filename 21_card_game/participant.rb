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
    return 1 if (total + 11 > 21)
    11
  end

  def display_hand
    output = ''
    hand.each { |card| output += " #{card} " }
    output
  end

  def >(other_participant)
    total_points > other_participant.total_points
  end

  def ==(other_participant)
    total_points == other_participant.total_points
  end
end

class Player < Participant
  include Inputable

  def hit?
    puts "Would you like to hit or stay?"
    input_hit_or_stay
  end
end

class Dealer < Participant
  def hit?
    total_points < 17
  end

  def display_concealed_hand
    output = ''
    hand.each_with_index { |card, ind|  ind == 0 ? output += " {HIDDEN} " : output += " #{card} " }
    output
  end
end
