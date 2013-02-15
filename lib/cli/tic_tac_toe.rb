require "cli/console_io"
require "cli/console"
require "cli/human"
require "game"
require "options"
require "game_runner"

class TicTacToe
  attr_reader :players

  def initialize(input, output)
    @clio = ConsoleIO.new(input, output)
    @console = Console.new(@clio)
    @game = Game.tic_tac_toe
    @options = Options.new(Human.new(@console))
  end

  def run
    @console.greet
    select_players
    @runner = GameRunner.new(@game, @players, Proc.new { |game| @console.draw_game(game) })

    until @game.game_over?
      begin
        @runner.take_turn
      rescue InvalidMoveException
        @console.invalid_input
      end
    end
  end

  def select_players
    @players = @console.select_player_types(@game.players.count, @options)
  end
end
