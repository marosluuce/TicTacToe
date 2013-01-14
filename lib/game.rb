require "board"
require "player"
require "input"

SYMBOLS = [:x, :o]

class Game
  attr_reader :board, :players

  def initialize
    @board = Board.tic_tac_toe
    @players = SYMBOLS.map { |s| Player.new(s) }
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
    Input.get_console_input
  end

  def validate_move(move)
    @board.get_available_squares.include? move.to_i
  end

  def run
    move
    update
    draw
  end

  def update
    @players.rotate!
  end

  def draw

  end
end
