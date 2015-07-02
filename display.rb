require_relative 'board'
require 'colorize'

class Display
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def render
    board.grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        string = tile.to_s
        if (x.even? && y.even?) || (x.odd? && y.odd?)
          print string.colorize(:background => :red)
        else
          print string.colorize(:background => :black)
        end
      end
      puts
    end
    nil
  end

end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
end
