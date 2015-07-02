require_relative 'board'
require_relative 'errors'
require 'colorize'
require 'io/console'

class Display
  WASD = {
    "a" => [0, -1],
    "s" => [1, 0],
    "d" => [0, 1],
    "w" => [-1, 0],
    "\r" => [0, 0]
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
    loop do
      system('clear')
      render_squares
      move = $stdin.getch
      break if move == "\r"
      unless WASD.keys.include?(move)
        raise InvalidKey.new "Please use 'a,s,d,w'"
      end
      delta = WASD[move]
      x, y = cursor
      dx, dy = delta
      @cursor = [x + dx, y + dy]
    end
    cursor
  end

  def render
    begin
      system('clear')
      select_square
    rescue InvalidKey => e
      puts e.message
      sleep(1)
      retry
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  board = Board.new
  display = Display.new(board)
  display.render
end
