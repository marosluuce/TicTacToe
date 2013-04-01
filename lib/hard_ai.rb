class HardAI
  def self.request_move(runner)
    move = get_move(runner.game)
    runner.make_move(move)
  end

  def self.get_move(game)
    if game.board.available_moves.include?(5)
      5
    elsif game.board.available_moves.count == 8
      [1, 3, 7, 9].sample
    else
      run_negamax(game)
    end
  end

  private
  def self.score_game(game)
    if game.winner.nil?
      0
    elsif game.winner == game.current_player
      1
    else
      -1
    end
  end

  def self.run_negamax(game)
    scores = game.board.available_moves.reduce({}) do |results, square|
      game.make_move(square)
      score = -negamax(game)
      game.undo_last_move
      results.merge({square => score})
    end
    scores.key(scores.values.max)
  end

  def self.negamax(game, depth=1)
    return score_game(game) if game.game_over?

    value = -999
    game.board.available_moves.each do |square|
      game.make_move(square)
      value = [value, -negamax(game, depth+1)].max
      game.undo_last_move
    end
    value /= Float(depth)
  end
end
