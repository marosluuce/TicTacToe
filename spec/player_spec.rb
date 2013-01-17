require "player"

describe Player do
  let(:sym) { :x }
  let(:p) { Player.new(sym, nil) }

  it "creates a player" do
    p.should be_an_instance_of Player
  end
  it "has a symbol" do
    p.should respond_to :sym
  end
  it "returns the correct symbol" do
    p.sym.should == sym
  end

  describe "#get_move" do
    it "should get a move from input" do
      p.input.should_receive(:request_move) { 1 }
      p.get_move
    end
  end
end
