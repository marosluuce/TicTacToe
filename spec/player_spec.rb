require "player"

describe Player do
  let(:sym) { :x }
  let(:p) { Player.new(sym) }

  it "creates a player" do
    p.should be_an_instance_of Player
  end
    it "has a symbol" do
    p.should respond_to :sym
  end
  it "returns the correct symbol" do
    p.sym.should == sym
  end
end
