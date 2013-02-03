require "game_builder"
require "game"

describe GameBuilder do
  let(:strat_nums) { [0, 1] }

  it "builds a new game" do
    GameBuilder.build(strat_nums).should be_an_instance_of Game
  end

  it "configures a board" do
    config = GameBuilder.configure_board({})
    config[:board].should be_an_instance_of Board
  end

  it "configures players" do
    config = GameBuilder.configure_players({}, "game", strat_nums)
    config[:players].count.should == GameBuilder::SYMBOLS.count
    config[:players].each do |player|
      player.should be_an_instance_of Player
    end
  end
end
