class EmptySpace

  def empty?
    true
  end

  def piece?
    false
  end

  def color
    :empty
  end

  def to_s
    '   '
  end

  def valid_steps
    "empty"
  end

  def valid_jumps
    "empty"
  end

end
