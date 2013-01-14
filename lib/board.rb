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
    i -= 1
    if i < @squares.count && @squares[i].nil?
      @squares[i] = val
    else
      false
    end
  end

  def get_available_squares
    avail = []
    @squares.each_with_index do |x, i|
      avail << (i + 1) if x.nil?
    end
    avail
  end

  def to_s
    string = ""
    @squares.map do |s|
      s.nil? ? " " : s
    end.each_slice(@width).with_index do |line, i|
      string << line.join("|")
      string << "\n#{"-" * (@width * 2 - 1)}\n" unless i == @length - 1
    end
    string
  end
end
