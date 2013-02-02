class Board
  attr_reader :squares, :width, :last_move

  def self.tic_tac_toe
    self.new(3, 3)
  end

  def initialize(length, width)
    @squares = Array.new(length * width) 
    @length = length
    @width = width
  end

  def set_square(i, val)
    if i > 0 && i < @squares.count + 1
      @last_move = i
      @squares[i-1] = val
    end
  end

  def set_square_nil(i)
    @squares[i - 1] = nil
    @last_move = nil
  end

  def available_squares
    @squares.each_with_index.map do |square, index|
      square.nil? ? index + 1 : nil
    end.compact
  end

  def to_s
    string = ""
    @squares.each_with_index.map do |s, i|
      s.nil? ? i + 1 : s.to_s
    end.each_slice(@width).with_index do |line, i|
      string << line.join("|")
      string << "\n#{"-" * (@width * 2 - 1)}\n" unless i == @length - 1
    end
    string
  end

  def full?
    !@squares.include? nil
  end

  def empty?
    @squares.compact.count == 0
  end
end
