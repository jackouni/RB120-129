require_relative 'lineable.rb'

class Tile
  attr_accessor :marking

  def to_s
    marking ? marking : ' '
  end

  def unmarked?
    marking == nil
  end

  def marked?
    marking != nil
  end

  def ==(other_tile)
    self.marking && self.marking == other_tile.marking
  end
end

class Board
  include Lineable

  attr_reader :tiles, :winning_line, :dimensions

  def initialize(dimensions)
    @tiles        = Array.new(dimensions) { Array.new(dimensions) {Tile.new} }
    @winning_line = nil
    @dimensions = dimensions
  end

  def to_s
    system('clear')
    board_str = ''

    grid_line         = "+-----" * dimensions + "+\n"
    empty_row_segment = "|     " * dimensions + "|\n"

    tiles.each do |row|
      board_str += grid_line
      
      (1..3).each do |row_segment|
        if row_segment == 2 # Middle segment of row, where a tile's marking will render
          row.each { |tile| board_str += "|  #{tile}  " }
          board_str += "|\n"
        else
          board_str += empty_row_segment
        end
      end
    end

    board_str += grid_line
    board_str
  end

  def full?
    tiles.all? { |row| row.all? { |tile| tile.marked? } }
  end

  def winning_line
    all_lines.each do |line|
      comparison_tile = line.first
      return line if line.all? { |tile| tile == comparison_tile }
    end

    nil
  end

  def someone_won?
    winning_line != nil
  end

  def reset 
    board.tiles.map! { |tile| tile.marking = nil }
  end
end
