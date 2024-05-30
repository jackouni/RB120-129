module Lineable
  def horizontal_lines
    tiles
  end

  def vertical_lines
    columns = []

    dimensions.times do |col_ind|
      column = []
      tiles.each { |row| column << row[col_ind] }
      columns << column
    end

    columns
  end

  def top_left_diagonal_line
    diagonal = []
    dimensions.times { |ind| diagonal << tiles[ind][ind] }
    diagonal
  end

  def top_right_diagonal_line
    reversed_rows = tiles.map(&:reverse)
    diagonal = []
    dimensions.times { |ind| diagonal << reversed_rows[ind][ind] }
    diagonal
  end

  def diagonal_lines
    [top_left_diagonal_line, top_right_diagonal_line]
  end

  def all_lines
    [diagonal_lines, vertical_lines, horizontal_lines].flatten(1)
  end
end
