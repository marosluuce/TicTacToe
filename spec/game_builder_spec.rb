require "game_builder"
require "game"
require "stringio"

describe GameBuilder do
  let (:fake_io) { StringIO.new() }
  let (:builder) { GameBuilder.new(fake_io) }

  it "builds a new game" do
    builder.should_receive(:configure_players)
    builder.build.should be_an_instance_of Game
  end

  it "sets a strategy each player" do
    fake_io.stub(:gets) { 1 }
    builder.configure_players
    builder.players.each do |player|
      player.strategy.should be_an_instance_of GameBuilder::STRATEGIES.values[0]
    end
  end
end
