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

  attr_reader :board, :cursor, :debug_mode

  def initialize(board)
    @board = board
    @cursor = [0,0]
    @debug_mode = true
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
    if debug_mode
      puts "Position: #{cursor}"
      puts "Possible Steps: #{board[cursor].valid_steps}"
      puts "Possible Jumps: #{board[cursor].valid_jumps}"
    end
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
      unless board.on_board?([x + dx, y + dy])
        raise InvalidKey.new "Please stay on the board"
      end
      @cursor = [x + dx, y + dy]
    end
    cursor
  end

  def render

  end

end
