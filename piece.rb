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

  def possible_jumps(pos)
    x, y = pos
    jumps = []
    JUMPS.each do |(dx, dy)|
      move = [x + dx, y + dy]
      possible_jumps << move if board.in_bounds?(move)
    end

    jumps    
  end

  def valid_jumps(pos)

  end

  def valid_steps(position)

  end

end
