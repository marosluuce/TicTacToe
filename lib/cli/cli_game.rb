require "cli/cli_io"
require "cli/cli_menu"
require "game"

class CliGame
  def initialize(input, output)
    @io = CliIO.new(input, output)
    @menu = CliMenu.new(@io)
    #@menu.greet
    @game = Game.tic_tac_toe
  end

  def run
    # This line shouldn't live here.
    #@menu.board(@game.board)
    until @game.game_over?
      #move
      draw
    end
  end

  #def move
    #begin
      #move = get_move
      #move = @io.gets if move.nil?
    #end until @game.valid_move?(move)
    #@game.make_move(move.to_i)
  #end

  #def get_move
    #@game.current_player.get_move
  #end

  def draw
    @menu.draw_game(@game)
  end
end
