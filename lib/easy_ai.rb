class EasyAI
  def self.get_move(game)
    game.board.available_moves.first
  end
end
