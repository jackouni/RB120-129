module Lineable
  def horizontal_lines
    self.tiles
  end

  def vertical_lines
    columns = []

    dimensions.times do |col_ind|
      column = []
      self.tiles.each { |row| column << row[col_ind] } 
      columns << column
    end

    columns
  end

  def top_left_diagonal_line
    diagonal = []
    dimensions.times { |ind| diagonal << self.tiles[ind][ind] }
    diagonal
  end
  
  def top_right_diagonal_line
    reversed_rows = self.tiles.map(&:reverse)
    diagonal = []
    dimensions.times { |ind| diagonal << reversed_rows[ind][ind] }
    diagonal
  end

  def diagonal_lines
    [self.top_left_diagonal_line, self.top_right_diagonal_line]
  end

  def all_lines
    [self.diagonal_lines, self.vertical_lines, self.horizontal_lines].flatten(1)
  end
end