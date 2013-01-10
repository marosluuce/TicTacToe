class Board
  attr_reader :squares, :length, :width

  def self.tic_tac_toe
    self.new(3, 3)
  end

  def initialize(length, width)
    @squares = Array.new(length * width) 
    @length = length
    @width = width
  end

  def set_square(i, val)
    if i < @squares.count && @squares[i] == nil
      @squares[i] = val
    else
      false
    end
  end

  def get_available_squares
    avail = []
    @squares.each_with_index do |x, i|
      avail << i unless x
    end
    avail
  end
end
