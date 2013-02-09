require "cli/cli_formatter"

# TODO Rename to CliConsole
class CliMenu
  GREETING = "Welcome to Tic-Tac-Toe!"
  CHOICES_PROMPT = "Enter your choice: "

  def initialize(clio)
    @clio = clio
  end

  def greet
    @clio.puts GREETING
  end

  # These two functions may not be necessary
  def show_choices(choices)
    @clio.prompt CliFormatter.player_choices(choices)
  end

  def prompt_choices
    @clio.prompt CHOICES_PROMPT
  end

  def board(board)
    @clio.puts CliFormatter.board(board)
  end

  def draw_game(game)
    @clio.puts CliFormatter.last_move(game.last_move)
    if game.game_over?
      @clio.puts CliFormatter.winner(game.winner)
    else
      @clio.puts CliFormatter.current_player(game.current_player)
    end
    board(game.board)
  end

  def request_players(players, options)
    Hash[
      players.collect do |player|
        choice = nil
        begin
          show_choices(options.player_names)
          choice = @clio.request_input(CHOICES_PROMPT).to_i - 1
        end until options.player_types.each_index.include?(choice)
        [player, options.player_types[choice]]
      end
    ]
  end
end
