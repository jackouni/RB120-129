class Tile
  attr_reader :marking

  def to_s
    marking ? marking : ' '
  end
end

class Board
  attr_reader :tiles
  attr_reader :winning_line

  def initialize
    @tiles        = Array.new(3) { Array.new(3) { Tile.new } }
    @winning_line = nil
  end

  def to_s
    system('clear')
    puts "+---+---+---+"
    
    tiles.each do |row|
      row.each_with_index do |tile, index|
        if index != 1
          print "| #{tile} |"
        else
          print " #{tile} "
        end
      end

      puts "\n"
    end

    puts "+---+---+---+"
  end
end
