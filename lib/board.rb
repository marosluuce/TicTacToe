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
    @squares.each_with_index.map do |s, i|
      s.nil? ? i + 1 : s
    end.each_slice(@width).with_index do |line, i|
      string << line.join("|")
      string << "\n#{"-" * (@width * 2 - 1)}\n" unless i == @length - 1
    end
    string
  end

  def full?
    not @squares.include? nil
  end

  def game_over?
    !winner.nil? || full?
  end

  def winner
    winning_player = nil
    (0...@width).each do |n|
      horiz = @squares.select.with_index { |s, i| i / @width == n }.uniq
      if horiz.count == 1 && !horiz.first.nil?
        winning_player = horiz.first
        break
      end
      vert = @squares.select.with_index { |s, i| i % @width == n }.uniq
      if vert.count == 1 && !vert.first.nil?
        winning_player = vert.first
        break
      end
      l_diag = @squares.select.with_index do |s, i|
        i / @width == i % @width
      end.uniq
      if l_diag.count == 1 && !l_diag.first.nil?
        winning_player = l_diag.first
        break
      end
      r_diag = @squares.select.with_index do |s, i|
        i % (@width - 1) == 0 && i != 0 && i != (@squares.count - 1)
      end.uniq
      if r_diag.count == 1 && !r_diag.first.nil?
        winning_player = r_diag.first
        break
      end
    end
    winning_player
  end
end
