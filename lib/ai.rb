class AI
  attr_reader :sym, :board

  def initialize(sym, opponent_sym, board)
    @sym = sym
    @opponent_sym = opponent_sym
    @board = board
  end

  def get_move
    if board.empty?
      5
    else
      select_move(run_negamax(@board))
    end
  end

  def score_board(board)
    winner = board.winner
    if winner == @sym
      1
    elsif winner == @opponent_sym
      -1
    elsif board.full?
      0
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
      moves[square] = -negamax(board, -1)
      board.set_square_nil(square)
    end
    moves
  end

  def negamax(board, color)
    return color * score_board(board) if board.game_over?

    value = -9999
    symbol = color == 1 ?  @sym : @opponent_sym
    board.available_squares.each do |square|
      board.set_square(square, symbol)
      value = [value, -negamax(board, -1 * color)].max
      board.set_square_nil(square)
    end
    value
  end
end
