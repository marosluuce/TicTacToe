require "options"

describe Options do
  it "is a list of player names" do
    Options.player_names.should == Options::PLAYERS.keys
  end

  it "is a list of player types" do
    Options.player_types.should == Options::PLAYERS.values
  end
end
