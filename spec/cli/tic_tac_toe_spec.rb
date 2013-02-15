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
    @options = Options.new(Human.new(@clio))
    Game.stub(:new).and_return(@game)
    ConsoleIO.stub(:new).and_return(@clio)
    Console.stub(:new).and_return(@console)
    Options.stub(:new).and_return(@options)
  end

  describe "#run" do
    before(:each) do
      fake_io.input << 1 << 1
    end

    it "selects players before running" do
      @console.stub(:select_player_types).and_return([EasyAI, EasyAI])
      ttt.run
    end

    it "is game over when after being run" do
      ttt.run
      @game.game_over?.should eq(true)
    end
  end

  it "is a list of the selected players" do
    fake_io.input << 2 << 2
    ttt.select_players
    ttt.players.each do |type|
      @options.player_types.should include(type)
    end
  end
end
