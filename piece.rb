class Piece

  def initialize(position, color)
    @position = position
    @color = color if color == :black || color == :red
  end

end
