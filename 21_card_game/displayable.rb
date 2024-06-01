module Displayable
  def welcome_message
    puts "--------------------------------"
    puts "Welcome #{player.name}, to Jack's 21 Card Game!!"
    puts "--------------------------------\n"
  end

  def display_hands
    puts "#{player.name} has #{player.total_points} points with: #{player.display_hand}"
    puts "#{dealer.name} has: #{dealer.display_concealed_hand}"
  end

  def display_revealed_hands
    puts "#{player.name} has #{player.total_points} points with:\n #{player.display_hand}"
    puts "#{dealer.name} has #{dealer.total_points} points with:\n #{dealer.display_hand}"
  end

  def display_tie
    puts "Tie game! No one wins."
  end

  def display_winner(winner)
    if winner.name != "The Dealer"
      puts "Congratulations #{winner.name}, you won!"
    else
      puts "The Dealer won the game! Better luck next time."
    end
  end

  def goodbye_message
    puts "Great game! Goodbye for now."
  end
end