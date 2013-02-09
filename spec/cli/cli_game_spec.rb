require "cli/cli_game"
require "cli/cli_io"
require "cli/mock_io"
require "easy_ai"
require "options"

describe CliGame do
  let(:fake_io) { MockIO.new }
  let(:ttt) { CliGame.new(fake_io, fake_io) }

  before(:each) do
    @game = Game.tic_tac_toe
    @clio = CliIO.new(fake_io, fake_io)
    @menu = CliMenu.new(@clio)
    Game.stub(:new).and_return(@game)
    CliIO.stub(:new).and_return(@clio)
    CliMenu.stub(:new).and_return(@menu)
    # TODO move hash creation into cli_game or runner.
    @menu.stub(:request_players).and_return({@game.players.first => EasyAI, @game.players.last => EasyAI})
  end

  it "is game_over when run ends" do
    ttt.run
    @game.game_over?.should eq(true)
  end

  it "draws the game" do
    @menu.should_receive(:draw_game).with(@game)
    ttt.draw
  end

  it "is a list of the selected players" do
    fake_io.input << 1 << 1
    ttt.select_players
    ttt.players.each do |key, value|
      key.should be_an_instance_of Player
      Options.player_types.should include(value)
    end
  end

  describe "#make_move" do
    it "makes the move of the current player if type is not nil" do
      player = ttt.players[@game.current_player]
      player.should_receive(:get_move).and_return(1)
      @game.should_receive(:make_move).with(1)
      ttt.make_move
    end

    it "makes asks for input if the current player if type is nil" do
      @menu.stub(:request_players).and_return({})
      @clio.should_receive(:request_input)
      ttt.make_move
    end
  end
end
