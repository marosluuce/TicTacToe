require "dumb_strategy"
require "board"

describe DumbStrategy do
  it "is the first available move" do
    board = Board.tic_tac_toe
    dumb = DumbStrategy.new(MockGame.new(board))
    dumb.get_move.should == board.available_squares.first
  end
end

class MockGame
  attr_reader :board

  def initialize(board)
    @board = board
  end
end
