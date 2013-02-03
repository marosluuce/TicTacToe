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

  def set_square(square, symbol)
    if square > 0 && square < @squares.count + 1
      @squares[square-1] = symbol
    end
  end

  def available_squares
    @squares.each_with_index.map do |square, index|
      square.nil? ? index + 1 : nil
    end.compact
  end

  def full?
    !@squares.include? nil
  end

  def empty?
    @squares.compact.count == 0
  end
end
