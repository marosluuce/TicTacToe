require "cli/cli_game"
require "stringio"

describe CliGame do
  let(:fake_input) { StringIO.new }
  let(:ttt) { CliGame.new(fake_input, fake_input) }

  # A little bit of a hack. Probably means this should be elsewhere.
  # Actualy, still broken. Need more tests. Should have written them before
  # but I'm still working out how stuff should be and I'm tired... :(
  before(:each) do
    fake_input.string = "2\n2\n"
  end

  it "is game_over when run ends" do
    ttt.run
    ttt.runner.game_over?.should eq(true)
  end

  describe "#get_move" do
    it "get's the current player's h" do

    end
  end
end
