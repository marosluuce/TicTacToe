require "cli/cli_game"
require "stringio"

describe CliGame do
  let(:fake_input) { StringIO.new }
  let(:ttt) { CliGame.new(fake_input, fake_input) }

  it "is game_over when run ends" do
    ttt.run
    ttt.runner.game_over?.should eq(true)
  end

  describe "#get_move" do
    it "get's the current player's h" do

    end
  end
end
