class Board
  attr_reader :squares, :length, :width, :last_move

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
    avail = []
    @squares.each_with_index do |x, i|
      avail << (i + 1) if x.nil?
    end
    avail
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
    not @squares.include? nil
  end

  def empty?
    @squares.uniq.count == 1 && @squares.first.nil?
  end

  def draw?
    full? && winner.nil?
  end

  def game_over?
    !winner.nil? || full?
  end

  def winner
    winning_player = nil
    possible_wins = []
    (0...@width).each do |n|
      possible_wins << @squares.select.with_index { |s, i| i / @width == n }.uniq
      possible_wins << @squares.select.with_index { |s, i| i % @width == n }.uniq
      possible_wins << @squares.select.with_index do |s, i|
        i / @width == i % @width
      end.uniq
      possible_wins << @squares.select.with_index do |s, i|
        i % (@width - 1) == 0 && i != 0 && i != (@squares.count - 1)
      end.uniq
    end

    possible_wins.each do |possible|
      if possible.count == 1 && !possible.first.nil?
        winning_player = possible.first
        break
      end
    end

    winning_player
  end
end
