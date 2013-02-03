require "easy_ai_strategy"
require "board"

describe EasyAIStrategy do
  it "is the first available move" do
    board = Board.tic_tac_toe
    easy = EasyAIStrategy.new(MockGame.new(board))
    easy.get_move.should == board.available_squares.first
  end
end

class MockGame
  attr_reader :board

  def initialize(board)
    @board = board
  end
end
