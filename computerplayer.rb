class ComputerPlayer

  attr_reader :name

  def initialize(name, color, board, display)
    @name, @color = name, color
    @board = board
    @display = display
    @captured_pieces = 0
  end

  def take_turn
    if any_jumps?
      piece = jumps_piece
      start_pos = piece.position
      end_pos = piece.valid_jumps_ai.sample
      board.move(start_pos, end_pos, color)
    else
      piece = step_piece
      start_pos = piece.position
      end_pos = piece.valid_steps_ai.sample
      board.move(start_pos, end_pos, color)
    end
  end

  def pieces
    board.grid.flatten.select { |piece| piece.color == color }
  end

  def any_jumps?
    pieces.each do |piece|
      return true if piece.another_turn?
    end
    false
  end

  def step_piece
    steps = []
    pieces.each do |piece|
      if piece.valid_steps_ai.count > 0
        steps << piece
      end
    end
    steps.sample
  end

  def jumps_piece
    jumps = []
    pieces.each do |piece|
      if piece.another_turn?
        jumps << piece
      end
    end
    jumps.sample
  end

  private
    attr_reader :color, :name, :display, :board


end
