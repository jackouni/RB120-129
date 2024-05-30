require_relative 'inputable'

class Player
  attr_reader :name, :marker, :score

  include Inputable

  def initialize(name, marker)
    @name   = name
    @marker = marker
    @score  = 0 
  end

  def same_name_as?(other_name)
    name == other_name
  end

  def same_marker?(other_player)
    marker == other_player.marker
  end

  def increment_score
    @score += 1
  end
end

class Human < Player
  def place_marker(board)
    tile = nil

    puts "#{name}, select a tile on the board"
    puts "(provide a row and column number):"

    loop do
      row = input_coordinate_for(:row, board.dimensions)
      col = input_coordinate_for(:column, board.dimensions)

      tile = board.tiles[row - 1][col - 1]
      break if tile.unmarked?
      puts "That tile is occupied, please select another tile."
    end

    tile.marking = marker
  end
end

class Computer < Player
  def place_marker(board)
    tile = nil

    loop do
      row    = rand(1..board.dimensions)
      column = rand(1..board.dimensions)
      tile = board.tile_at(row, column)
      break if tile.unmarked?
    end
    
    tile.marking = marker
  end
end
