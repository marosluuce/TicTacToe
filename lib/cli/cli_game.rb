require "cli/cli_io"
require "cli/cli_formatter"
require "game_runner"
require "game_builder"

class CliGame
  attr_reader :runner

  def initialize(input, output)
    @io = CliIO.new(input, output)

    player_choices = ["Easy AI", "Easy AI"]
    @runner = GameRunner.new(GameBuilder.build(player_choices))
  end

  def run
    draw
    until @runner.game_over?
      move
      draw
    end
  end

  def move
    begin
      move = get_move
      move = @io.gets if move.nil?
    end while not @runner.validate_move(move)
    @runner.do_move(move.to_i)
  end

  def get_move
    @runner.current_player.get_move
  end

  def draw
    @io.puts CliFormatter.last_move(@runner.last_move)
    if @runner.game_over?
      @io.puts CliFormatter.winner(@runner.winner)
    else
      @io.puts CliFormatter.current_player(@runner.current_player)
    end
    @io.puts CliFormatter.board(@runner.board)
  end
end
