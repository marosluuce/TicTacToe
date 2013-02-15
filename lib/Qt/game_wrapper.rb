require "Qt4"
require "Qt/human"
require "game"
require "game_runner"

class GameWrapper < Qt::Object
  signals "game_over(QString)", :updated

  def initialize
    super()
    @game = Game.tic_tac_toe
  end

  def new_game(players)
    @game = Game.tic_tac_toe
    @runner = GameRunner.new(@game, players, Proc.new { update; Qt::CoreApplication.processEvents })
  end

  def take_turn
    @runner.take_turn
  end

  def update
    if @game.game_over?
      #TODO Put this under test
      message = if @game.draw?
                  "Draw!"
                else
                  winner = @game.winner.to_s
                  "#{winner.upcase} Won!"
                end
      emit game_over(message)
    end
    emit updated
  end

  def make_move(move)
    @runner.make_move(move)
  rescue InvalidMoveException
  end

  def square(number)
    @game.board.square(number)
  end

  def board_size
    @game.board.size
  end
end
