class Piece

  attr_reader :color
  attr_accessor :position

  def initialize(position, color)
    @position = position
    @color = color if color == :white || color == :red
  end

  def empty?
    false
  end

  def piece?
    true
  end

  def to_s
    color == :white ? ' \u25cd ' : ' \u25cf '
  end

end
