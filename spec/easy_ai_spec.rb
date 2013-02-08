require "easy_ai"
require "board"
require "game"

describe EasyAI do
  before(:each) do
    @board = Board.tic_tac_toe
    Board.stub(:new).and_return(@board)
    @game = Game.tic_tac_toe
  end
  it "is the first available move" do
    EasyAI.get_move(@game).should == @board.available_moves.first
  end
end
