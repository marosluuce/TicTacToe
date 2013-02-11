require "options"

describe Options do
  it "is a list of player names" do
    Options.player_names.should == Options::PLAYERS.keys
  end

  it "is a list of player types" do
    Options.player_types.should == Options::PLAYERS.values
  end

  it "is a list of valid numberical choices for players" do
    stub_const("Options::PLAYERS", {"a" => nil, 3 => nil})
    Options.player_choices.should == [0, 1]
  end
end
