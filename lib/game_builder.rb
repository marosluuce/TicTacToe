require "game"
require "board"
require "player"
require "easy_ai_strategy"
require "hard_ai_strategy"

class GameBuilder
  STRATEGIES = {
    "Human" => nil,
    "Easy AI" => EasyAIStrategy,
    "Hard AI"  => HardAIStrategy
  }
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
    strat_nums.each_with_index do |strat, i|
      strategy = STRATEGIES[strat].nil? ? nil : STRATEGIES[strat].new(game)
      config[:players] << Player.new(SYMBOLS[i], strategy)
    end
    config
  end
end
