require "cli/console_io"
require "cli/console"
require "game"
require "options"

class TicTacToe
  attr_reader :players

  def initialize(input, output)
    @clio = ConsoleIO.new(input, output)
    @console = Console.new(@clio)
    @game = Game.tic_tac_toe
  end

  def prepare_for_game
    @console.greet
    select_players
    @console.board(@game.board)
  end

  def run
    prepare_for_game
    until @game.game_over?
      take_turn
    end
  end

  def take_turn
    make_move
    draw
  end

  def select_players
    @players = @console.select_player_types(@game.players, Options)
  end

  def make_move
    player = @players[@game.current_player]
    move =
      if player.nil?
        # This may want to live in console.
        @clio.request_input("Enter your move: ").to_i
      else
        player.get_move(@game)
      end
    @game.make_move(move)
  rescue InvalidMoveException
    @console.invalid_input
  end

  def draw
    @console.draw_game(@game)
  end
end
