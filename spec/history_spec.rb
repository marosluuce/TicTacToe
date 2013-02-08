require "history"

describe History do
  let(:history) { History.new }

  it "is the number of moves that have been made" do
    history.count.should == 0
    history.add_move(9)
    history.count.should == 1
  end

  it "is nil when no moves have been made" do
    history.last_move.should be_nil
  end

  it "adds a move to the history" do
    history.add_move(9)
    history.last_move.should == 9
  end

  it "returns nil when removing the last move from an empty history" do
    history.remove_last_move.should be_nil
    history.last_move.should be_nil
  end

  it "removes and returns a move from the history" do
    history.add_move(9)
    history.remove_last_move.should == 9
    history.last_move.should be_nil
  end
end
