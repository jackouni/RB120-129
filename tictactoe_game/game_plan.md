# OOD Tic Tac Toe Game

## Game Description:
TicTacToe is a 2 player game where players take turns placing their respective marker on a square of a 3x3 board. The first player to get a straight line of 3 of their symbol on the board wins (diagonal, horizontal or vertical). Otherwise if the board is full and neither player has made a straight line (a win) of 3 with their marker, it's a tie game.

## Description The Game's Flow:
### Start Game 
1. Player 1 chooses a marker
1. Player 2 chooses a marker (that is **NOT** the same marker as player 1's)

### Main Game Play Loop 🔁
1. #### Player 1 chooses a square on the board to place their marker
    - ***IF*** all spaces on board are full ***THEN BREAK*** this loop
    - ***IF*** square on board is occupied ***THEN*** repeat step 1 of this Loop
2. #### Evaluate if Player 1 wins
    - ***IF*** a winning line is detected ***THEN BREAK*** this loop

3. #### Player 2 chooses a square on the board to place their marker
    - ***IF*** all spaces on board are full ***THEN BREAK*** this loop
    - ***IF*** square on board is occupied ***THEN*** repeat step 3 of this Loop
4. #### Evaluate if Player 2 wins
    - ***IF*** a winning line is detected ***THEN BREAK*** this loop

### End Game 
1. Check for winner
2. Display winning message
3. Display Goodbye message

---
---

# OOD
Nouns:
- Player
- Board
- Game
- Symbol
  - X 
  - O
- Line
  - Horizontal
  - Vertical
  - Diagonal

Verbs:
- placing_marker
- take_turn
- win
- play

## Organization:
- Game
  - Display
  - play
  - board_evaluated
  - wins?

  - Player
    - Human
        - place_marker 
      - Marker
    - Computer
        - place_marker 
      - Marker
      
  - Board
    - Square

## Object Relationships:
The **game** itself is an entity. It initializes the gameplay and determines the rules and outcomes. Sort of like a game-master that dictates and decides the laws and rules for the world our objects play and interact in.

A **Game** has-a **board** and a **board** has **squares** (9 of them). Each **square** has-a **mark** AND has-a **coordinate**.

A **Game** has **players** each **player** has-a **name** AND has-a **marker**. 

A **Marker** collaborates with a **Player** and is used to determine what **Squares** are *"owned/marked"* by that **Player** 

A **Square** collaborates with a **Board** to help determine if the board is full
A **Square** collaborates with a **Game** to help determine if there's a win or tie


## Object Behaviours & Interactions:
### **Games** can:
- Initiate a game
- display: goodbye, winner, tie game, scores, the board's state and welcome messages
- Determine a winner
- Create **Player** for the game
- Create a **Board** for the game to be played on

### **Players** can:
- Choose a name 
- Choose/Create a **Marker**
- place a marker on a **Square** on the **Board**

### **Boards** can:
- Detemine if there's a winning line 
- Determine if all Squares are full
 
📝 *(Two behaviours above could possibly be **Game** behaviours instead?)*

### **Markers** can:
- ???

(Not a *"can"* but are *used* for marking a **Square** so that it can be identified with a **Player**)

### **Squares** can:

(Not a *"can"* but are *used* for determining the state of the **Board** and *used* for evaluating winning lines, tie games and full boards)

---
---

## Notes 📝
- Does a Game determine if there's a win? Or does the Board determine if there's a win? I think you could potentially make the case for both:
  - The **Game** itself, with its rules and over-seeing power of the game play and game flow is what determines if a board has a winning position. The Board (of any kind) is just a Board that players are interacting with, the **Game** that is being played is what decides the winner. </br> </br>
  - The **Board** determines a winner. A **Board** decides who wins because it has built-in mechanics/rules in its Class that determine if it is in a winning state. Idk if that makes sense 😅

<br>

- Building off the last note: Are the rules/behaviours between objects built-into the **Board** being played on or the **Game** being played?

- I'm thinking that I can have the rules that involve many objects of more distant collaboration/relationships to be held within the **Game** class itself. All the main objects in the **Game** are collaborators to the **Game** itself. To determine a winner the Board with its Squares and the Markers with Players need to accessed, in this case I think it makes sense to hold the `determine_winner` behaviour to be something the **Game** decides. 

- With that last note, the Board can determine if it is `full?` or has a `winning_line` because it only needs to collaborate with the Squares that it collaborates with to determine these things. It doesn't need to interact with other non-collaborating objects. Therefore these can be behaviours for the **Board**

- I don't think I need a class for the marker itself. I think this can be an existing Class of object that can collaborate with the **Player**, like a **String**. The Marker from what I can think of so far has no behaviours specific to it and has no collaborators of its own. 

- Do I even need a **Square** Class object or can I just make the **Board** itself a 3x3 **Array** matrix, where each element represents a **Square**? The **Square** itself does not necessarily need any behaviours. A **Square** can tell us if it is `occupied?`, maybe? I guess the **Square** could maybe reference a **Player** instead, and then through the **Player** it references we can access the **Player**'s **Marker** to render or use for logic? So it collaborates with a **Player**. 
<br>
<br>
Okay, maybe a **Square** is going to be an object of its own 😛

---
# Final Descisions ✅

- A **Marker** *WILL NOT* be its own Class of object. It will simply be a String object that collaborates with a **Player**
- A **Square** will be its own Class of object and will collaborate with a **Player** that marks it. 
- A **Square's** behaviours: `occupied?`
- A **Board's**  behaviours: `is_full?`, `winning_line?` (not determining a winner, but determining a winning line... Not 100% sure on this one yet. If the **Game** is determining a winner then is it necessary?) 
- **Board** collaborates with a 3x3 **Array Matrix** where each element in the nested Array contains a **Square**: <br>
```ruby
[
  [sq0, sq1, sq2], 
  [sq3, sq4, sq5], 
  [sq6, sq7, sq8]
]

# Winning positions:
# IF any row is all? of 1 marker (horizontal lines)
# IF all? rows' 0th, 1st or 2nd indexes contain the same marker (vertical lines)
# IF each rows' element indexes that are ascending/descending from 0th to 2nd row are the same. (diagonal lines)
```
