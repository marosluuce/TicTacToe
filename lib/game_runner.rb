class GameRunner
  def initialize(game)
    @game = game
  end

  def board
    @game.board
  end

  def game_over?
    @game.game_over?
  end

  # This function probably needs to go away.
  def turn
    @game.move
    @game.update
    @game.draw
  end
end
