require "cli/cli_io"
require "cli/cli_formatter"
require "cli/cli_menu"
require "game_runner"
require "game_builder"

class CliGame
  attr_reader :runner

  def initialize(input, output)
    @io = CliIO.new(input, output)
    @menu = CliMenu.new(@io)
  end

  def run
    @menu.greet
    @runner = GameRunner.new(GameBuilder.build(player_choices))
    @io.puts CliFormatter.board(@runner.board)
    until @runner.game_over?
      move
      draw
    end
  end

  def move
    begin
      move = get_move
      move = @io.gets if move.nil?
    end until @runner.validate_move(move)
    @runner.do_move(move.to_i)
  end

  def get_move
    @runner.current_player.get_move
  end

  def player_choices
    choices = []
    GameBuilder::SYMBOLS.each do |_|
      choices << player_select
    end
    choices
  end

  def player_select
    @io.puts "Player Select"
    begin
      @menu.show_choices(GameBuilder::STRATEGIES)
      @menu.prompt_choices
      choice = @io.gets.to_i
    end until choice > 0 && choice <= GameBuilder::STRATEGIES.count
    GameBuilder::STRATEGIES.keys[choice - 1]
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
