class Piece
  JUMPS_WHITE = [[2, 2],
                 [2, -2]]

  JUMPS_RED = [[-2, 2],
               [-2, -2]]

  STEPS_RED = [[-1, 1],
               [-1, -1]]

  STEPS_WHITE = [[1, 1],
                 [1, -1]]

  attr_reader :color

  def initialize(position, color, board)
    @board = board
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
    if king
      color == :white ? "\u25ef  " : "\u2b24  ".colorize(:red)
    else
      color == :white ? " \u25cd " : " \u25cf ".colorize(:red)
    end
  end

  def update_position(new_pos)
    self.position = new_pos
    if color == :red && position[0] == 0
      king_yourself
    elsif color == :white && position[0] == 7
      king_yourself
    end
  end

  def valid_move?(end_pos)
    total_moves = valid_jumps + valid_steps

    total_moves.include?(end_pos)
  end

  def another_turn?
    valid_jumps.count > 0
  end

  private
    attr_reader :board
    attr_accessor :king, :position

    def king_yourself
      self.king = true
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
        moves << move if board.on_board?(move) && board[move].empty?
      end

      moves
    end

    def valid_jumps
      possible_jumps = possible_moves(:jump)

      possible_jumps.select { |jump| piece_between?(position, jump)}
    end

    def piece_between?(start_pos, end_pos)
      x, y = start_pos
      dx, dy = end_pos

      space = [((x + dx)/2), ((y + dy)/2)]
      piece = board[space]

      piece.piece? && piece.color != color
    end

    def valid_steps
      possible_moves(:step)
    end
end
