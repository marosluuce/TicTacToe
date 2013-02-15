require "options"

describe Options do
  let(:options) { Options.new("fake_human") }

  it "is a list of player names" do
    options.player_names.each { |name| name.should be_an_instance_of String }
  end

  it "is a list of player types" do
    options.player_types.each { |type| type.should_not be_nil }
  end

  it "is a list of types from given choices" do
    options.players_from_choices([0, 1]).should == [EasyAI, HardAI]
  end
end
