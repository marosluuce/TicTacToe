require "player"
require "board"

describe Player do
  let(:strategy) { "strategy" }
  let(:board) { Board.tic_tac_toe }
  let(:player) { Player.new(:x, board, strategy) }

  it "picks a valid move" do
    strategy.stub(:get_move) { board.available_squares.first }
    board.available_squares.should include(player.get_move)
  end

  it "can assign a new strategy" do
    new_strategy = "new_strategy"
    player.change_strategy(new_strategy)
    player.strategy.should == "new_strategy"
  end
end
