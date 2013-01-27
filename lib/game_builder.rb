require "game"
require "board"
require "player"
require "main_menu"
require "input_strategy"
require "dumb_strategy"
require "negamax"

class GameBuilder
  STRATEGIES = {1 => InputStrategy, 2 => DumbStrategy, 3 => Negamax}
  SYMBOLS = [:x, :o]

  attr_reader :players

  def initialize(io)
    @io = io
    @menu = MainMenu.new(io, STRATEGIES)
    @board = Board.tic_tac_toe
    @players = SYMBOLS.map { |symbol| Player.new(symbol) }
  end

  def build
    @menu.display_welcome
    configure_players
    Game.new(@players, @board)
  end

  def configure_players
    @players.each do |player|
      choice = @menu.request_player_choice
      strategy = STRATEGIES[choice].new(@players, @board, Input)
      player.change_strategy(strategy)
    end
  end
end
