require "cli/tic_tac_toe"
require "cli/mock_io"
require "easy_ai"

describe TicTacToe do
  let(:fake_io) { MockIO.new }
  let(:ttt) { TicTacToe.new(fake_io, fake_io) }

  before(:each) do
    @game = Game.tic_tac_toe
    @clio = ConsoleIO.new(fake_io, fake_io)
    @console = Console.new(@clio)
    Game.stub(:new).and_return(@game)
    ConsoleIO.stub(:new).and_return(@clio)
    Console.stub(:new).and_return(@console)
    # TODO move hash creation into tic_tac_toe or runner.
    @console.stub(:select_player_types).and_return({@game.players.first => EasyAI, @game.players.last => EasyAI})
  end

  it "prepares for the game" do
    @console.should_receive(:greet)
    ttt.should_receive(:select_players)
    @console.should_receive(:board)
    ttt.prepare_for_game
  end

  it "prepares and takes turns until the game is over" do
    ttt.run
    @game.game_over?.should eq(true)
  end

  it "takes a turn" do
    ttt.prepare_for_game
    ttt.should_receive(:make_move)
    ttt.should_receive(:draw)
    ttt.take_turn
  end

  it "draws the game" do
    @console.should_receive(:draw_game).with(@game)
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
      ttt.prepare_for_game
      player = ttt.players[@game.current_player]
      player.should_receive(:get_move).and_return(1)
      @game.should_receive(:make_move).with(1)
      ttt.make_move
    end

    it "makes asks for input if the current player if type is nil" do
      @console.stub(:select_player_types).and_return({})
      ttt.prepare_for_game
      @clio.should_receive(:request_input).and_return(1)
      ttt.make_move
    end

    it "prings a message when it receives InvalidMoveException" do
      ttt.prepare_for_game
      @game.stub(:make_move).and_raise(InvalidMoveException)
      @console.should_receive(:invalid_input)
      ttt.make_move
    end
  end
end
