require_relative 'inputable.rb'

class Player
  attr_reader :name, :marker
  include Inputable

  def initialize(name, marker)
    @name   = name
    @marker = marker
  end

  def same_name?(other_name)
    name == other_name
  end

  def same_marker?(other_player)
    marker == other_player.marker
  end
end
 
class Human < Player
  def place_marker(board)
    dimensions = board.dimensions
    tile = nil

    puts "#{name}, select a tile on the board (provide a row and column number):"
    loop do
      row = get_coordinate_for(:row, dimensions)
      col = get_coordinate_for(:column, dimensions)
      
      tile = board.tiles[row-1][col-1]
      break if tile.unmarked?
      puts "That tile is occupied, please select another tile."
    end

    tile.marking = self.marker
  end
end

class Computer < Player
  def place_marker(board)
    tile = nil

    loop do
      row  = (0..board.dimensions).to_a.sample
      col  = (0..board.dimensions).to_a.sample
      tile = board.tiles[row-1][col-1]
      break if tile.unmarked?
    end

    tile.marking = self.marker
  end
end