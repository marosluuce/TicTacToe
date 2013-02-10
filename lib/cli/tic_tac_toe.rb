require "cli/console_io"
require "cli/console"
require "game"
require "options"

class TicTacToe
  attr_reader :players

  def initialize(input, output)
    @clio = ConsoleIO.new(input, output)
    @console = Console.new(@clio)
    #@console.greet
    @game = Game.tic_tac_toe
    select_players
  end

  def run
    # This line shouldn't live here.
    #@console.board(@game.board)
    until @game.game_over?
      make_move
      draw
    end
  end

  def select_players
    @players = @console.request_players(@game.players, Options)
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
