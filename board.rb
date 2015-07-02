require_relative 'piece'
require_relative 'emptyspace'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) { Array.new(8) {EmptySpace.new} }
    setup_board
  end

  def [](pos)
    x, y = pos

    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos

    @grid[x][y] = value
  end

  def move(start_pos, end_pos, color)
    current_piece = self[start_pos]

    if current_piece.color != color
      raise InvalidMove.new "That is not your piece"
    end

    unless current_piece.valid_move?(end_pos)
      raise InvalidMove.new "That is an invalid move"
    end

    self[end_pos] = current_piece
    self[start_pos] = EmptySpace.new

    current_piece.update_position(end_pos)

    if jump?(start_pos, end_pos)
      remove_piece(start_pos, end_pos)
      raise GreatJump.new "Take another turn" if current_piece.another_turn?
    end

  end

  def on_board?(pos)
    pos.all? {|coord| coord.between?(0, grid.length - 1)}
  end

  def won?
    grid.flatten.none? { |piece| piece.color == :red } ||
    grid.flatten.none? { |piece| piece.color == :white}
  end


  private

    def inspect
      @grid.each_with_index do |row, x|
        row.each_with_index do |tile, y|
          print "#{tile.color}: #{[x, y]} "
        end
        puts
      end
    end

    def jump?(start_pos, end_pos)
      x, y = start_pos
      dx, dy = end_pos

      [x.abs - dx.abs, y.abs - dy.abs].all? { |coord| coord.abs == 2 }
    end

    def remove_piece(start_pos, end_pos)
      x, y = start_pos
      dx, dy = end_pos

      piece_pos = [((x + dx)/2), ((y + dy)/2)]
      self[piece_pos] = EmptySpace.new
    end

    def setup_board
      [:red, :white].each do |color|
        grid.each_with_index do |row, x|
          row.each_with_index do |space, y|
            next self if color == :red && x < 5
            break if color == :white && x > 2

            if x.even? && y.odd?
              pos = [x, y]
              self[pos] = Piece.new(pos, color, self)
            end

            if x.odd? && y.even?
              pos = [x,y]
              self[pos] = Piece.new(pos, color, self)
            end

          end
        end
      end
    end
end
