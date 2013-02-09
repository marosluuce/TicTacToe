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

  def size
    @squares.count
  end

  def square(number)
    @squares[number - 1]
  end

  def make_move(square, symbol)
    @squares[square-1] = symbol
  end

  def undo_move(square)
    @squares[square-1] = nil
  end

  def available_moves
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
