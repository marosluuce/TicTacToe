class EasyAI
  def self.request_move(runner)
    move = get_move(runner.game)
    runner.make_move(move)
  end

  def self.get_move(game)
    game.board.available_moves.first
  end
end
