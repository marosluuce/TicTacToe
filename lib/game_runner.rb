require "game"
require "options"

class GameRunner
  attr_reader :players

  def initialize
    @players = {}
    @game = Game.tic_tac_toe
  end

  def set_players(choices)
    choices.map! { |choice| Options.player_types[choice] }
    @players = Hash[@game.players.zip(choices)]
  end
end
