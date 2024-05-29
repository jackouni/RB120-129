require_relative 'inputable.rb'

class Player
  attr_reader :name, :marker
  include Inputable

  def initialize(name, marker)
    @name   = name
    @marker = marker
  end

  
  def place_marker(board)
    tile = nil

    puts "#{name}, select a tile on the board (provide a row and column number):"
    loop do
      row = get_coordinate_for("row")
      col = get_coordinate_for("column")
      
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
      row  = [0, 1, 2].sample
      col  = [0, 1, 2].sample
      tile = board.tiles[row][col]
      break if tile.unmarked?
    end

    tile.marking = self.marker
  end
end