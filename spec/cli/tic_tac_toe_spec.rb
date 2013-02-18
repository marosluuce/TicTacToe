require "cli/tic_tac_toe"
require "cli/mock_io"
require "easy_ai"

describe TicTacToe do
  let(:fake_io) { MockIO.new }
  let(:players) { [EasyAI, EasyAI] }
  let(:ttt) { TicTacToe.new(fake_io, fake_io) }

  before(:each) do
    @game = Game.tic_tac_toe
    @clio = ConsoleIO.new(fake_io, fake_io)
    @console = Console.new(@clio)
    @options = Options.new(Human.new(@clio))
    @runner = GameRunner.new(@game, players)
    Game.stub(:new).and_return(@game)
    ConsoleIO.stub(:new).and_return(@clio)
    Console.stub(:new).and_return(@console)
    Options.stub(:new).and_return(@options)
    GameRunner.stub(:new).and_return(@runner)
  end

  describe "#prepare_game" do
    it "greets the user" do
      @console.should_receive(:greet)
      ttt.prepare_game
    end

    it "creates a game runner" do
      ttt.prepare_game
      ttt.runner.should == @runner
    end
  end

  it "is game over when after being run" do
    ttt.prepare_game
    ttt.run
    @game.game_over?.should eq(true)
  end

  it "prints invalid move message for invalid input" do
    @runner.stub(:take_turn).and_raise(InvalidMoveException)
    @console.should_receive(:invalid_input)
    ttt.prepare_game
    ttt.take_turn
  end

  it "is a list of the selected players" do
    fake_io.input << 2 << 2
    ttt.select_players.each do |type|
      @options.player_types.should include(type)
    end
  end
end
