class Negamax
  def initialize(player1, player2)
    @game_players = [player1, player2]
  end

  def get_move(board, calling_player)
    available = board.available_squares
    if available.include?(5)
      5
    elsif available.count == 8
      [1, 3, 7, 9].sample
    else
      select_move(run_negamax(board, calling_player))
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

  def run_negamax(board, calling_player)
    players = @game_players
    players.rotate! if calling_player != players.first

    moves = {}
    board.available_squares.each do |square|
      board.set_square(square, players.first)
      moves[square] = -negamax(board, players)
      board.set_square_nil(square)
    end
    moves
  end

  def negamax(board, players, depth=1)
    symbol = depth.even? ? players.first : players.last
    return score_board(board, symbol) if board.game_over?

    value = -9999
    board.available_squares.each do |square|
      board.set_square(square, symbol)
      value = [value, -negamax(board, players, depth+1)].max
      board.set_square_nil(square)
    end
    value /= Float(depth)
  end
end
