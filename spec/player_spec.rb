require "player"
require "board"

describe Player do
  let(:board) { Board.tic_tac_toe }

  it "is a valid move if strategy is not nil" do
    player = Player.new(:x, MockStrategy.new(board))
    board.available_squares.should include(player.get_move)
  end

  it "is a nil move if strategy is nil" do
    player = Player.new(:x)
    player.get_move.should be_nil
  end
end

class MockStrategy
  def initialize(board)
    @board = board
  end

  def get_move
    @board.available_squares.first
  end
end
