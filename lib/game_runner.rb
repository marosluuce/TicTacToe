class GameRunner
  attr_reader :game

  def initialize(game)
    @game = game
  end

  def board
    @game.board
  end

  def do_move(square)
    @game.do_move(square)
  end

  def validate_move(move)
    board.available_squares.include? move.to_i
  end

  def last_move
    @game.last_move
  end

  def game_over?
    @game.game_over?
  end

  def current_player
    @game.current_player
  end

  def winner
    @game.winner
  end
end
