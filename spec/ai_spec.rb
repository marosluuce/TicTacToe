require "ai"
require "board"

describe AI do
  let(:board) { Board.tic_tac_toe }
  let(:strategy) { "strategy" }
  let(:ai) { AI.new(:o, board, strategy) }

  describe "#get_move" do
    it "picks a valid move" do
      strategy.stub(:get_move) { board.available_squares.first }
      board.available_squares.should include(ai.get_move)
    end
  end

  describe "#change_strategy" do
    it "assigns the new strategy" do
      new_strategy = "new_strategy"
      ai.change_strategy(new_strategy)
      ai.strategy.should == "new_strategy"
    end
  end
end
