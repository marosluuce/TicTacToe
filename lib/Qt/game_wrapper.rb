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
      emit game_over(end_game_message)
    end
    emit updated
  end

  def end_game_message
    @game.draw? ? "Draw!" : "#{@game.winner.to_s.upcase} Won!"
  end

  def make_move(move)
    @runner.make_move(move)
  rescue InvalidMoveException
  end

  def last_move
    @game.last_move
  end

  def current_player
    @game.current_player.to_s
  end

  def square(number)
    @game.board.square(number)
  end

  def board_size
    @game.board.size
  end
end
