require "dumb_strategy"
require "board"

describe DumbStrategy do
  it "is the first available move" do
    board = Board.tic_tac_toe
    dumb = DumbStrategy.new(nil, board, nil)
    dumb.get_move(nil).should == board.available_squares.first
  end
end
