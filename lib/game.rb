require_relative "board"
require_relative "player"
require_relative "input"
require_relative "display"
require_relative "ai"

class Game
  attr_reader :board, :players

  def initialize(players, board)
    @board = board
    @players = players
  end

  def do_move(i, sym)
    @board.set_square(i.to_i, sym)
  end

  def move
    begin
      move = get_move
    end while not validate_move(move)
    do_move(move, @players.first)
  end

  def get_move
    @players.first.get_move
  end

  def validate_move(move)
    @board.available_squares.include? move.to_i
  end

  def request_move
    Input.request_move
  end

  def run
    Display.display("Welcome to Tic-Tic-Toe!\n")
    draw

    until @board.game_over?
      turn
    end
  end

  def turn
    move
    update
    draw
  end

  def update
    @players.rotate!
  end

  def draw
    Display.print_last_move(@board.last_move)
    if @board.game_over?
      Display.print_winner(@board.winner)
    else
      Display.print_turn(@players.first)
    end
    Display.display("#{@board}")
  end
end
