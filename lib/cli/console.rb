require "cli/formatter"

class Console
  GREETING = "Welcome to Tic-Tac-Toe!"
  CHOICES_PROMPT = "Enter your choice: "
  INVALID_INPUT = "Invalid input!"

  def initialize(clio)
    @clio = clio
  end

  def greet
    @clio.puts GREETING
  end

  # These two functions may not be necessary
  def show_choices(choices)
    @clio.prompt Formatter.player_choices(choices)
  end

  def prompt_choices
    @clio.prompt CHOICES_PROMPT
  end

  def board(board)
    @clio.puts Formatter.board(board)
  end

  def invalid_input
    @clio.puts INVALID_INPUT
  end

  def draw_game(game)
    @clio.puts Formatter.last_move(game.last_move)
    if game.game_over?
      @clio.puts Formatter.winner(game.winner)
    else
      @clio.puts Formatter.current_player(game.current_player)
    end
    board(game.board)
  end

  # TODO Split this method up so that it's easier to read.
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
