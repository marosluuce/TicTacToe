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
end
