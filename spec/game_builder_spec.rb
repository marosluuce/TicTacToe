require "game_builder"
require "game"

describe GameBuilder do
  it "builds a new game" do
    GameBuilder.build.should be_an_instance_of Game
  end

end
