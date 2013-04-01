require "cli/formatter"

class Console
  GREETING = "Welcome to Tic-Tac-Toe!"
  CHOICES_PROMPT = "Enter your choice: "
  MOVE_PROMPT = "Enter your move: "
  INVALID_INPUT = "Invalid input!"

  def initialize(io)
    @io = io
  end

  def greet
    @io.puts GREETING
  end

  def show_choices(choices)
    @io.prompt Formatter.player_choices(choices)
  end

  def prompt_choices
    @io.prompt CHOICES_PROMPT
  end

  def board(board)
    @io.puts Formatter.board(board)
  end

  def invalid_input
    @io.puts INVALID_INPUT
  end

  def prompt_move
    @io.prompt MOVE_PROMPT
    @io.gets
  end

  def draw_game(game)
    @io.puts Formatter.last_move(game.last_move)
    if game.game_over?
      @io.puts Formatter.winner(game.winner)
    else
      @io.puts Formatter.current_player(game.current_player)
    end
    board(game.board)
  end

  def select_player_types(player_count, options)
    Array.new(player_count).map { |_| request_player(options) }
  end

  def request_player(options)
    choice = nil
    until options.player_types.include?(choice)
      show_choices(options.player_names)
      selection = @io.request_input(CHOICES_PROMPT).to_i - 1
      choice = options.player_types[selection]
    end
    choice
  end
end
