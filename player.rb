require_relative 'display'
require_relative 'board'
require 'byebug'

class Player
  attr_reader :color, :name, :display, :board

  def initialize(name, color, board, display)
    @name, @color = name, color
    @board = board
    @display = display
    @captured_pieces = 0
  end

  def take_turn
    start_pos = display.select_square
    end_pos = display.select_square

    board.move(start_pos, end_pos, color)
  end


end
