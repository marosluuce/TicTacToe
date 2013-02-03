class Game
  attr_reader :board, :players, :move_history

  def initialize
    @move_history = []
  end

  def load_config(config)
    @board = config[:board]
    @players = config[:players]
    self
  end

  def last_move
    @move_history.last
  end

  def undo_last_move
    move = @move_history.pop
    @board.set_square(move, nil)
  end

  # I don't like this whole off by one thing...Maybe move to hash?
  def do_move(square)
    if @board.squares[square - 1].nil?
      @board.set_square(square, current_player)
      @move_history << square
    end
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
        i % (@board.width - 1) == 0 && i != 0 && i != (@board.squares.count - 1)
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

  def current_player
    @players[@move_history.count % @players.count]
  end
end
