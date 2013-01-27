class Negamax
  def self.to_s
    "Smart AI"
  end

  def initialize(players, board, io)
    @players = players
    @board = board
  end

  def get_move(calling_player)
    available = @board.available_squares
    if available.include?(5)
      5
    elsif available.count == 8
      [1, 3, 7, 9].sample
    else
      @players.rotate! if calling_player != @players.first
      run_negamax
    end
  end

  private
  def score_board(symbol)
    winner = @board.winner
    if winner.nil?
      0
    elsif winner == symbol
      1
    else
      -1
    end
  end

  def run_negamax
    best_move = nil
    value = -999
    @board.available_squares.each do |square|
      @board.set_square(square, @players.first)
      score = -negamax()
      @board.set_square_nil(square)

      if score > value
        value = score
        best_move = square
      end
    end
    best_move
  end

  def negamax(depth=1)
    symbol = depth.even? ? @players.first : @players.last
    return score_board(symbol) if @board.game_over?

    value = -9999
    @board.available_squares.each do |square|
      @board.set_square(square, symbol)
      value = [value, -negamax(depth+1)].max
      @board.set_square_nil(square)
    end
    value /= Float(depth)
  end
end
