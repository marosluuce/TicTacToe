require "cli/cli_io"
require "cli/cli_menu"
require "game"
require "options"

class CliGame
  attr_reader :players

  def initialize(input, output)
    @clio = CliIO.new(input, output)
    @menu = CliMenu.new(@clio)
    #@menu.greet
    @game = Game.tic_tac_toe
    select_players
  end

  def run
    # This line shouldn't live here.
    #@menu.board(@game.board)
    until @game.game_over?
      make_move
      draw
    end
  end

  def select_players
    @players = @menu.request_players(@game.players, Options)
  end

  def make_move
    player = @players[@game.current_player]
    move =
      if player.nil?
        @clio.request_input("Enter your move: ").to_i
      else
        player.get_move(@game)
      end
    @game.make_move(move)
  end

  def draw
    @menu.draw_game(@game)
  end
end
