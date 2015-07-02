require_relative 'board'
require 'colorize'
require 'io/console'

class Display
  WASD = {
    "a" => [0, -1],
    "s" => [-1, 0],
    "d" => [0, 1],
    "w" => [1, 0],
    '\r' => [0, 0]
  }

  attr_reader :board, :cursor

  def initialize(board)
    @board = board
    @cursor = [0,0]
  end

  def render_squares
    board.grid.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        string = tile.to_s
        if [x, y] == cursor
          print string.colorize(:background => :blue)
        elsif (x.even? && y.even?) || (x.odd? && y.odd?)
          print string.colorize(:background => :red)
        else
          print string.colorize(:background => :black)
        end
      end
      puts
    end
    nil
  end

  def select_square
    move = $stdin.getch
    raise InvalidKey.new "Please use 'a,s,d,w'"
          unless WASD.keys.include?(move)
    delta = WASD[move]
    x, y = cursor
    dx, dy = delta
    @cursor = [x + dx, y + dy]
  end

  def render

  end

end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
end
