class AI
  attr_reader :sym, :board

  def initialize(sym, opponent_sym, board)
    @sym = sym
    @opponent_sym = opponent_sym
    @board = board
  end

  def get_move
    available = @board.available_squares
    if @board.empty? || (available.count == 8 && available.include?(5))
      5
    elsif available.count == 8 && !available.include?(5)
      [1, 3, 7, 9].sample
    else
      select_move(run_negamax(@board))
    end
  end

  private
  def score_board(board, symbol)
    winner = board.winner
    if winner.nil? && board.full?
      0
    elsif winner == symbol
      1
    else
      -1
    end
  end

  def select_move(moves)
    max_value = moves.max_by { |_, v| v }.last
    moves.select { |_, v| v == max_value }.keys.to_a.first
  end

  def run_negamax(board)
    moves = {}
    board.available_squares.each do |square|
      board.set_square(square, @sym)
      moves[square] = -negamax(board)
      board.set_square_nil(square)
    end
    moves
  end

  def negamax(board, depth=1)
    symbol = depth.odd? ? @opponent_sym : @sym
    return score_board(board, symbol) if board.game_over?

    value = -9999
    board.available_squares.each do |square|
      board.set_square(square, symbol)
      value = [value, -negamax(board, depth+1)].max
      board.set_square_nil(square)
    end
    value /= Float(depth)
  end
end
