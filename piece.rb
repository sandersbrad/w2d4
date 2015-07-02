require_relative 'board'
require 'byebug'

class Piece
  JUMPS_WHITE = [[2, 2],
                 [2, -2]]


  STEPS_WHITE = [[1, 1],
                 [1, -1]]

  STEPS_RED = [[-1, 1],
               [-1, -1]]

  JUMPS_RED = [[-2, 2],
               [-2, -2]]


  attr_reader :color, :board
  attr_accessor :position, :king

  def initialize(position, color, board)
    @board = board
    @position = position
    @color = color if color == :white || color == :red
    @king = false
  end

  # def king
  #   self.king == true
  # end

  def empty?
    false
  end

  def piece?
    true
  end

  def to_s
    color == :white ? " \u25cd " : " \u25cf ".colorize(:red)
  end

  def possible_moves(type)
    x, y = position
    moves = []

    case color
    when :red
      vectors = type == :step ? STEPS_RED : JUMPS_RED
    when :white
      vectors = type == :step ? STEPS_WHITE : JUMPS_WHITE
    end

    if king
      vectors = STEPS_RED + STEPS_WHITE + JUMPS_RED + JUMPS_WHITE
    end

    vectors.each do |(dx, dy)|
      move = [x + dx, y + dy]
      moves << move if board.on_board?(move)
    end

    moves
  end


  # Need to complete
  def valid_jumps
    possible_steps_first = possible_moves(:step)
    possible_jumps_first = possible_moves(:jump)

    possible_jumps = []
    possible_steps = []

    possible_jumps_first.each_with_index do |pos, idx|
      if board.on_board?(pos)
        possible_jumps << pos
        possible_steps << possible_steps_first[idx]
      end
    end

    jumps = []

    possible_steps.each_with_index do |pos, idx|
      if board[pos].piece? && board[pos].color != color
        jumps << possible_jumps[idx]
      end
    end

    jumps
  end

  def valid_steps
    possible_moves(:step).select { |new_pos| board[new_pos].empty? }
  end

  def opponent(color)
    color == :white ? :red : :white
  end

  def update_position(new_pos)
    self.position = new_pos
  end

end
