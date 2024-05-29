module Lineable
  def horizontal_lines
    self.tiles
  end

  def vertical_lines
    columns = []

    3.times do |col_ind|
      column = []
      self.tiles.each { |row| column << row[col_ind] } 
      columns << column
    end

    columns
  end

  def top_left_diagonal_line
    diagonal = []
    3.times { |ind| diagonal << self.tiles[ind][ind] }
    diagonal
  end
  
  def top_right_diagonal_line
    reversed_rows = self.tiles.map(&:reverse)
    diagonal = []
    3.times { |ind| diagonal << reversed_rows[ind][ind] }
    diagonal
  end

  def diagonal_lines
    [self.top_left_diagonal_line, self.top_right_diagonal_line]
  end

  def all_lines
    [self.diagonal_lines, self.vertical_lines, self.horizontal_lines].flatten(1)
  end
end

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

  attr_reader :tiles
  attr_reader :winning_line

  def initialize
    @tiles        = Array.new(3) { Array.new(3) {Tile.new} }
    @winning_line = nil
  end

  def to_s
    system('clear')
    board_str = ''

    grid_line         = "+-----+-----+-----+\n"
    empty_row_segment = "|     |     |     |\n"

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
end
