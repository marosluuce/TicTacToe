require "player"
require "board"

describe Player do
  let(:player) { Player.new(:x) }

  it "is a string with the player's symbol" do
    player.to_s.should == "x"
  end
end
