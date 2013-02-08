require "cli/cli_formatter"

class CliMenu
  GREETING = "Welcome to Tic-Tac-Toe!"
  CHOICES_PROMPT = "Enter your choice: "

  def initialize(clio)
    @clio = clio
  end

  def greet
    @clio.puts GREETING
  end

  def show_choices(choices)
    @clio.puts CliFormatter.player_choices(choices.keys)
  end

  def prompt_choices
    @clio.prompt CHOICES_PROMPT
  end

  def board(board)
    @clio.puts CliFormatter.board(board)
  end

  def show_turn(game)
    @clio.puts CliFormatter.last_move(game.last_move)
    if game.game_over?
      @clio.puts CliFormatter.winner(game.winner)
    else
      @clio.puts CliFormatter.current_player(game.current_player)
    end
    board(game.board)
  end
end
