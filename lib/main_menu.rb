require "board"
require "player"
require "game"
require "input_strategy"
require "dumb_strategy"
require "negamax"

class MainMenu
  WELCOME_MESSAGE = "Welcome to Tic-Tac-Toe!"
  PLAYER_CHOICES = "1. Human\n2. Dumb AI\n3. Smart AI"
  USER_PROMPT = "Enter your choice: "

  attr_reader :players

  def initialize(io)
    @io = io
    @board = Board.tic_tac_toe
    @players = [Player.new(:x), Player.new(:o)]
  end

  def request_choice
    #@io.puts USER_PROMPT
    choice = nil
    until [1, 2, 3].include?(choice)
      choice = @io.gets.to_i
    end
    choice
  end

  def display_choices
    @io.puts PLAYER_CHOICES
  end

  def display_welcome
    @io.puts WELCOME_MESSAGE
  end

  def request_player_choice
    display_choices
    request_choice
  end

  def give_player_strategy(player, strategy_number)
    case strategy_number
    when 1
      strategy = InputStrategy.new(Input)
    when 2
      strategy = DumbStrategy.new(@board)
    when 3
      strategy = Negamax.new(@players, @board)
    end
    player.change_strategy(strategy)
  end

  def configure_players
    @players.each do |player|
      choice = request_player_choice
      give_player_strategy(player, choice)
    end
  end

  def run
    display_welcome
    configure_players
    Game.new(@players, @board)
  end
end
