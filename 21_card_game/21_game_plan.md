bbb# OOD 21 Card Game

## Game Description:

21 is a card game that consists of a two participants: a dealer and a player. And a regular 52 card deck.

> The 52 card deck consists of 4 suites: hearts, diamonds, spades and clubs. 
> And 13 values: 2, 3, 4, 5, 6, 7, 8, 9, 10, jack, king, queen and ace

Each player is initially dealt 2 cards each. The player can see their cards but can only see one of the dealer's cards.
The goal of 21 is to play the cards you're dealt whilst trying to get as close to 21 points as you can without going over 21.

#### Card values are as shown:
|Card               |Value     |
|:------------------|:--------:|
| 2-10              | card's # |
| King, Jack, Queen | 10       | 
| Ace               | 1 or 11  |

The player makes the first move first. The player can either *"hit"* or *"stay"*. A "hit" means the player will ask for another card from the deck to add to the total points they hold. Again, if they exceed 21 points they *"bust* and they lose. A player can *hit* as many times as they want until they either *bust* or *stay*.

Once a player says *"stay"* this means they don't pick up another card and now it is the dealer's turn.
The dealer follows a strict rule: if their total is below 17 they *hit*. If their total is over 17 they *stay* and reveal their cards. If the dealer goes over 21 they bust and lose.

Whoever's value is the closest to 21 wins.

---

## OO Design:

### Nouns:

- Game
  - Goal
  - Participant?
    - Player
    - Dealer

      - Points
      - Hand
      - Total
  - Deck
    - Card
      - Value
      - King
      - Queen
      - Ace

### Verbs:

- dealt
- see cards
- move
- hit
- stay
- bust
- add total points
- hold
- follows a strict rule
- reveal
- lose
- wins

### Organize Classes:

- Game
  > ***<ins>Behaviours:</ins>*** </br>
  > winner()             <br/>
  > display_winner()     <br/>
  > display_tie()        <br/>
  > reveal_dealer_hand() <br/>
  > ***<ins>Attributes/Properties:</ins>*** </br>
  > a Deck   </br>
  > a Player </br>
  > a Dealer </br>

  - Participants
    > ***<ins>Behaviours:</ins>*** </br>
    > hit()          </br>
    > stay()         </br>
    > move()         </br>
    > total_points() </br>
    > bust()?        <br/>
    > ***<ins>Attributes/Properties:</ins>*** </br>
    > hand           </br>
    
    - Player
    - Dealer
      > ***<ins>Behaviours:</ins>*** </br>
      > is_less_than_17?() *("strict rule")* </br>
    
  - Deck
    > shuffler()          <br/>
    > remaining_cards()   <br/>
    > deal_cards_to(player, amount)
  - Card
    > value <br/>
    > suite <br/>
    > type

---

## Object Relationships:

The **Game** itself is an entity that controls the main flow of the game. It decides who wins, who loses, what to display and when as well as who gets dealt what based on a **Partcipant**'s actions (consequence of invoking a behaviour). The **Deck** itself will deal cards to **Participants**. I'm deciding to do this because it creates less points of contact, the dealing of a decks cards directly to a **Participant's** hand is a lot smoother than getting the **Game** itself interact with the **Deck** to then give the **Card** to the **Participant**. This will also result in less method calls and make the code that much more readable.

A **Game** *has-a* **Player**, *has-a* **Dealer**, and *has-a* **Deck**.

A **Deck** *has* **Card**s

A **Participant** *has-a* hand of **Card**s, and *has-a* name.

A **Card** collaborates with a **Participant**

A **Card** collaborates with a **Deck**

## Object Interactions and Behaviours:

#### Games Can:
- initiate a game
- determine who wins
- determine a tie
- display appropriate images and/or messages
- create a **Deck**
- create **Participants** and **Dealer**
- display the reveal of a **Dealer's** hand

#### Cards:
- Have value
- Have suite
- Have type

#### Decks:
- can be shuffled
- can create **Cards**
- can show their remaining **Cards**
- can deal cards to players
- have **Cards**

#### Participants:
- can hit
- can stay
- can determine if bust?
- can make a move
- have a hand of **Cards**

#### Dealers:
- can determine if points are under 17 <br/>
*(And everything else in Participants)*

#### Players:
- have a name <br/>
*(And everything else in Participants)*
--- 

## Game Steps

### High-level:
1. **Player** states their name
2. Two **Cards** are dealt to each Participant
3. **Player** makes a move
4. **Dealer** makes a move
5. A winner or tie is determined

### Detailed:
1. **Player** states their name
2. **Deck** deals two **Cards** are to each **Participant**

3. **Player** makes a move
    - `if bust?` skip **Dealer's** turn and determine a winner
    - **Deck** deals a **Card** to **Player** `if hit?`
    - **Dealer's** turn `if stay?`
    
4. **Dealer** makes a move
    - `if bust?` determine a winner
    - `hit?  if` `total_points < 17`
    - `stay? if` `total_points >= 17`

5. A winner or tie is determined
  - `if Dealer.bust?` **Player** wins
  - `if Player.bust?` **Dealer** wins
  - `if Dealer.points == Player.points` Tie game, no one wins
  - `if Player.points > Dealer.points` **Player** wins
  - `if Player.points < Dealer.points` **Dealer** wins

--- 

