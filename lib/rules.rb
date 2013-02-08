class Rules
  def initialize(board)
    @board = board
  end

  def draw?
    @board.full? && winner.nil?
  end

  def game_over?
    @board.full? || !winner.nil?
  end

  def winner
    possible_wins = []
    (0...@board.width).each do |n|
      possible_wins << @board.squares.select.with_index do  |s, i|
        i / @board.width == n
      end.uniq
      possible_wins << @board.squares.select.with_index do |s, i|
        i % @board.width == n
      end.uniq
      possible_wins << @board.squares.select.with_index do |s, i|
        i / @board.width == i % @board.width
      end.uniq
      possible_wins << @board.squares.select.with_index do |s, i|
        i % (@board.width - 1) == 0 &&
        i != 0 && i != (@board.squares.count - 1)
      end.uniq
    end

    winning_player = nil
    possible_wins.each do |possible|
      if possible.count == 1 && !possible.first.nil?
        winning_player = possible.first
        break
      end
    end

    winning_player
  end
end
