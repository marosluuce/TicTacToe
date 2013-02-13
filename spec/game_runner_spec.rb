require "game_runner"

describe GameRunner do
  let(:runner) { GameRunner.new }

  before(:each) do
    @game = Game.tic_tac_toe
    Game.stub(:new).and_return(@game)
  end

  it "is a mapping of player to strategy" do
    runner.set_players([0, 1])

    runner.players.keys.should == @game.players
    runner.players.values.each_with_index do |type, index|
      type.should == Options.player_types[index]
    end
  end
end
