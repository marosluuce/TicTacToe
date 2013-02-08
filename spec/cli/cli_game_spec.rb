require "cli/cli_game"
require "options"
require "stringio"

describe CliGame do
  let(:fake_input) { StringIO.new }
  let(:ttt) { CliGame.new(fake_input, fake_input) }

  before(:each) do
    # I don't like this mock so much...
    #@game = Game.tic_tac_toe
    @game = mock(Game, :game_over? => true)
    Game.stub(:new).and_return(@game)
    @menu = mock(CliMenu, :draw_game => nil)
    CliMenu.stub(:new).and_return(@menu)
    ttt.stub(:move_sources).and_return([Options::PLAYER_CHOICES[1], Options::PLAYER_CHOICES[1]])
  end

  it "is game_over when run ends" do
    ttt.run
    @game.game_over?.should eq(true)
  end

  it "gets the current player's move" do
  end

  it "draws the current state" do
    @menu.should_receive(:draw_game).with(@game)
    ttt.draw
  end
end
