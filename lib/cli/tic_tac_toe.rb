require "cli/console_io"
require "cli/console"
require "cli/human"
require "game"
require "options"
require "game_runner"

class TicTacToe
  attr_reader :runner

  def initialize(input, output)
    @clio = ConsoleIO.new(input, output)
    @console = Console.new(@clio)
    @game = Game.tic_tac_toe
    @options = Options.new(Human.new(@console))
  end

  def prepare_game
    @console.greet
    @runner = GameRunner.new(@game, select_players, Proc.new { |game| @console.draw_game(game) })
  end

  def run
    until @game.game_over?
      take_turn
    end
  end

  def take_turn
    @runner.take_turn
  rescue InvalidMoveException
    @console.invalid_input
  end

  def select_players
    @console.select_player_types(@game.players.count, @options)
  end
end
