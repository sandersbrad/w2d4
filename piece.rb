class Piece
  JUMPS = [[2, 2],
           [-2, 2],
           [2, -2],
           [-2, -2]]

  STEPS = [[1, 1],
           [-1, 1],
           [1, -1],
           [-1, -1]]

  attr_reader :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color if color == :white || color == :red
    @king = false
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def to_s
    color == :white ? " \u25cd " : " \u25cf ".colorize(:red)
  end

  def possible_moves(type, pos)
    x, y = pos
    moves = []
    vectors = type == step ? STEPS : JUMPS
    vectors.each do |(dx, dy)|
      move = [x + dx, y + dy]
      moves << move if board.in_bounds?(jump)
    end

    moves
  end


  # Need to complete
  # def valid_jumps(pos, color)
  #   opponent_pieces = possible_moves(step, pos).select do |new_pos|
  #     tile = board[new_pos]
  #     tile.piece? && tile.color != color
  #   end
  #
  #   possible_moves(jump, pos)
  # end

  def valid_steps(pos)
    possible_moves(step, pos).select { |new_pos| board[new_pos].empty? }
  end

  def opponent(color)
    color == :white ? :red : :white
  end

end
