## OOP Tic Tac Toe Game

=begin  
  Desc:
    Tic Tac Toe is a 2 player game where players take turns between placing their designated symbol (X or O) on a 
    square on a 3x3 grid-board. The first player to place 3 of their symbols in a line from one end of the board to the other 
    (horizontal, diagonal, verticle) wins. Otherwise if no winning position evaluated then it's a tie game.


  Nouns:
    • Player
    • Board
    • Game
    • Symbol
      - X 
      - O
    • Line
      - Horizontal
      - Vertical
      - Diagonal

  Verbs:
    • placing_symbol
    • take_turn
    • winning_position_evaluated
    • play

  Organize:
    • Game
      ** Display
      - play
      - board_evaluated
      - wins?

      • Player
        • Human
          - placing_symbol / take_turn
          • Symbol
        • Computer
          - placing_symbol / take_turn
          • Symbol
        
      • Board
        • Square
      
=end

