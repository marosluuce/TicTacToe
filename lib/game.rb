require_relative "board"
require_relative "player"
require_relative "input"
require_relative "display"
require_relative "ai"

#SYMBOLS = [:x, :o]

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.tic_tac_toe
    #@players = SYMBOLS.map { |s| Player.new(s) }
    @players = [Player.new(:x, self), AI.new(:o, @board)]
  end

  def do_move(i, sym)
    @board.set_square(i.to_i, sym)
  end

  def move
    begin
      move = get_move
    end while not validate_move(move)
    do_move(move, @players.first.sym)
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
    Display.display(@board)
  end
end
