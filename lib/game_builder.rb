require "game"
require "board"
require "player"
require "input_strategy"
require "dumb_strategy"
require "negamax"

class GameBuilder
  def self.build
    board = Board.tic_tac_toe
    players = [Player.new(:x), Player.new(:o)]
    Game.new(players, board)
  end
end
