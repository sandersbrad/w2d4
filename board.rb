require_relative 'piece'
require_relative 'emptyspace'

class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {EmptySpace.new} }
    setup_board
  end

  def [](pos)
    x, y = pos

    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos

    @grid[x][y] = value
  end

  def inspect
    @grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        print "#{tile.color}: #{[x, y]} "
      end
      puts
    end
  end


  def setup_board
    [:red, :white].each do |color|
      grid.each_with_index do |row, x|
        row.each_with_index do |space, y|
          next self if color == :red && x < 5
          break if color == :white && x > 2

          if x.even? && y.odd?
            pos = [x, y]
            self[pos] = Piece.new(pos, color)
          end

          if x.odd? && y.even?
            pos = [x,y]
            self[pos] = Piece.new(pos, color)
          end

        end
      end
    end
  end
end

board = Board.new
board.inspect
