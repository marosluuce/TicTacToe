require "board"
require "player"

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
    @players.first.get_input
  end

  def validate_move(move)
    found = false
    @board.get_available_squares.each do |s|
      if s.to_s == move
        found = true
        break
      end
    end
    found
  end
end
