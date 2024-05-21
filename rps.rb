class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    @@round = 1
    system("clear")
  end

  def play
    display_welcome_message

    loop do
      puts "ROUND: #{@@round}"
      puts "SCORES: #{human.name} => #{human.score} | #{computer.name} => #{computer.score}"

      human.choose
      computer.choose
      puts "#{human.name} Chose: #{human.move}"
      puts "Computer Chose: #{computer.move}"

      update_scores
      display_winner

      break unless play_again?
      @@round += 1
      system("clear")
    end

    display_goodbye_message
  end

  def display_welcome_message
    puts "Welcome to RPS!!"
  end

  def update_scores
    return nil if human.move == computer.move
    human.move > computer.move ? human.score += 1 : computer.score += 1
  end

  def display_winner
    if human.move == computer.move
      puts "No one wins. Tie game."

    elsif human.move > computer.move
      puts "#{human.name} wins!"

    elsif human.move < computer.move
      puts "#{computer.name} wins!"
    end
  end

  def display_goodbye_message
    puts "That was a good game. Goodbye now."
  end

  def play_again?
    puts "Would you like to play again? (Type 'y' for 'yes' and 'n' for 'no')"
    answer = gets.chomp

    loop do
      break if answer.match(/(n|y)/i)
      puts "Please enter a valid answer of: ['y', 'n']"
      answer = gets.chomp
    end

    case answer
    when "y" then true
    else false
    end
  end
end

class Player
  attr_accessor :score, :name, :move

  def initialize
    @score = 0
    @move  = nil
  end
end

class Human < Player
  def initialize
    puts "Enter a name:"
    @name = gets.chomp
    super
  end

  def choose
    puts "Choose from => ['rock', 'paper', 'scissors']"
    choice = gets.chomp.downcase

    until ['rock', 'paper', 'scissors'].include?(choice)
      puts "Please enter a valid option of ['rock', 'paper', 'scissors']"
      choice = gets.chomp.downcase
    end

    self.move = Move.new(choice)
  end
end

class Computer < Player
  def initialize
    @name = "Computer Player"
    super
  end

  def choose
    choice = ['rock', 'paper', 'scissors'].sample
    self.move = Move.new(choice)
  end
end

class Move
  attr_reader :move_type

  def initialize(choice)
    @move_type = choice
  end

  def to_s
    move_type
  end

  def scissors?
    move_type == 'scissors'
  end

  def rock?
    move_type == 'rock'
  end

  def paper?
    move_type == 'paper'
  end

  def >(other_move)
    return other_move.scissors? if rock?
    return other_move.rock?     if paper?
    return other_move.paper?    if scissors?
  end

  def <(other_move)
    return other_move.paper?    if rock?
    return other_move.scissors? if paper?
    return other_move.rock?     if scissors?
  end

  def ==(other_move)
    move_type == other_move.move_type
  end
end

game = RPSGame.new
game.play
