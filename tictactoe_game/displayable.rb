module Displayable
  def welcome_message
    puts "Welcome to Jack's OOP Tic Tac Toe!"
    puts "----------------------------------"
  end

  def display_winner(winner)
    if winner
      puts "Congratualations #{winner.name}, you won!"
    else
      display_tie
    end
  end

  def display_tie
    puts "Tie game, no one wins."
  end

  def goodbye_message
    puts "That was a great game. Goodbye for now!"
  end
end