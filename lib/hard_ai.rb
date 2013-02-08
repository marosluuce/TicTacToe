class HardAI
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

  # I still don't like this duplication...
  def self.run_negamax(game)
    best_move = nil
    value = -999
    game.board.available_moves.each do |square|
      game.make_move(square)
      score = -negamax(game)
      game.undo_last_move

      if score > value
        value = score
        best_move = square
      end
    end
    best_move
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
