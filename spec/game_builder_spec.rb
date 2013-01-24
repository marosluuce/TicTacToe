require "game_builder"
require "game"
require "input"
require "display"

describe GameBuilder do
  let(:builder) { GameBuilder.new() }#Input, Display) }

  it "builds a new game" do
    builder.build.should be_an_instance_of Game
  end
end
