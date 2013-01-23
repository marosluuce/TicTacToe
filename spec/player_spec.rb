require "player"

describe Player do
  let(:symbol) { :x }
  let(:fake_input) { Object.new }
  let(:player) { Player.new(symbol, fake_input) }

  it "creates a player" do
    player.should be_an_instance_of Player
  end
  it "has a symbol" do
    player.should respond_to :sym
  end
  it "returns the correct symbol" do
    player.sym.should == symbol
  end

  describe "#get_move" do
    it "should get a move from input" do
      fake_input.stub(:request_move) { "1" }
      player.get_move.should be_a String
    end
  end
end
