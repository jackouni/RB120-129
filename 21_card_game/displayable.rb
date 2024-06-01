module Displayable
  def clear_display
    system('clear')
  end

  def welcome_message
    clear_display
    puts "------------------------------------------------"
    puts "Welcome #{player.name}, to Jack's 21 Card Game!!"
    puts "------------------------------------------------"
    puts "\n"
    sleep(2.25)
  end

  def show_hands
    clear_display
    puts "#{player.name} has #{player.total_points} points with: #{player.show_hand}"
    puts "\n"
    puts "#{dealer.name} has: #{dealer.show_concealed_hand}"
    puts "\n"
  end

  def show_revealed_hands
    clear_display
    puts "#{player.name} has #{player.total_points} points with:\n #{player.show_hand}"
    puts "\n"
    puts "#{dealer.name} has #{dealer.total_points} points with:\n #{dealer.show_hand}"
    puts "\n"
  end

  def display_tie
    puts "Tie game! No one wins."
  end

  def display_winner(winner)
    if winner.name == "The Dealer"
      puts "The Dealer won the game! Better luck next time."
    else
      puts "Congratulations #{winner.name}, you won!"
    end
  end

  def goodbye_message
    puts "Great game! Goodbye for now."
    sleep(2.5)
    clear_display
  end

  def display_bust_message
    if player.bust?
      puts "YOU BUSTED!"
    else
      puts "THE DEALER BUSTED!"
    end

    puts "\n"
  end
end
