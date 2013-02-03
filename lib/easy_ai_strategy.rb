class EasyAIStrategy
  def initialize(game)
    @game = game
  end

  def get_move
    @game.board.available_squares.first
  end
end
