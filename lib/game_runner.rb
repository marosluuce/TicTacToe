require "game"
require "options"

class GameRunner
  attr_reader :players, :game

  def initialize(game, chosen_player_types, block=Proc.new{})
    @game = game
    @players = set_players(chosen_player_types)
    @block = block
  end

  def set_players(chosen_player_types)
    Hash[@game.players.zip(chosen_player_types)]
  end

  def take_turn
    @block.call(@game)

    unless @game.game_over?
      move = current_move_source.request_move(self)
    end
  end

  def make_move(move)
    @game.make_move(move)
    take_turn
  end

  def current_move_source
    @players[@game.current_player]
  end
end
