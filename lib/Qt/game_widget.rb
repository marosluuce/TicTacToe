require "Qt4"
require "Game"

class GameWrapper < Qt::Object
  signals :game_over

  attr_reader :game

  def initialize
    super()
    reset
  end

  def reset
    @game = Game.tic_tac_toe
  end

  def update
    if @game.game_over?
      emit game_over
    end
  end

  def make_move(move)
    @game.make_move(move)
    update
  end

  def square(number)
    @game.board.square(number)
  end

  def board_size
    @game.board.size
  end
end
