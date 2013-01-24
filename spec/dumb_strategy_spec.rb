require "dumb_strategy"
require "board"

describe DumbStrategy do
  it "is the first available move" do
    board = Board.tic_tac_toe
    DumbStrategy.get_move(board, nil).should == board.available_squares.first
  end
end
