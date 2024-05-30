require_relative 'lineable'

class Board
  include Lineable

  attr_reader :tiles, :winning_line, :dimensions

  def initialize(dimensions)
    @tiles        = Array.new(dimensions) { |row| Array.new(dimensions) { |column| Tile.new(row, column) } }
    @winning_line = nil
    @dimensions   = dimensions
  end

  def to_s
    board_str = ''

    grid_line         = ("+-----" * dimensions) + "+\n"
    empty_row_segment = ("|     " * dimensions) + "|\n"

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
    tiles.all? { |row| row.all?(&:marked?) }
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

  def tile_unmarked?(row, column)
    tile = tiles[row - 1][column - 1]
    tile.unmarked?
  end

  def reset
    tiles.each do |row|
      row.each { |tile| tile.marking = nil }
    end
  end

  def tile_at(row, column)
    tiles[row - 1][column - 1]
  end
end

class Tile
  attr_accessor :marking
  attr_reader :row, :column
  
  def initialize(row, column)
    @row = row
    @column = column
  end
  
  def to_s
    marking || ' '
  end

  def unmarked?
    marking.nil?
  end

  def marked?
    marking != nil
  end

  def ==(other_tile)
    marking && marking == other_tile.marking
  end

  def row_column
    [row, column]
  end
end
