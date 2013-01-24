require "game"
require "board"
require "player"
require "input_strategy"
require "dumb_strategy"
require "negamax"

class GameBuilder
  def initialize()#input, output)
   # @input = input
   # @output = output
  end

  def configure
    # config = GameConfiguration.new(input, output).configure
  end

  def build
    board = Board.tic_tac_toe
    players = [Player.new(:x), Player.new(:o)]
    Game.new(players, board)
  end
end
