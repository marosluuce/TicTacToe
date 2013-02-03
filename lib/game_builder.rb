require "game"
require "board"
require "player"
require "dumb_strategy"
require "negamax"

class GameBuilder
  STRATEGIES = {1 => nil, 2 => DumbStrategy, 3 => Negamax}
  SYMBOLS = [:x, :o]

  def self.build(strat_nums)
    config = {}
    game = Game.new
    configure_board(config)
    configure_players(config, game, strat_nums)
    game.load_config(config)
    game
  end

  def self.configure_board(config)
    config[:board] = Board.tic_tac_toe
    config
  end

  def self.configure_players(config, game, strat_nums)
    config[:players] = []
    strat_nums.each_with_index do |num, i|
      strategy = STRATEGIES[num].nil? ? nil : STRATEGIES[num].new(game)
      config[:players] << Player.new(SYMBOLS[i], strategy)
    end
    config
  end
end
