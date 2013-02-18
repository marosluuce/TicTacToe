require "spec_helper"
require "game_runner"
require "easy_ai"

describe GameRunner do
  let(:game) { Game.tic_tac_toe }
  let(:players) { [EasyAI, EasyAI] }
  let(:runner) { GameRunner.new(game, players) }

  it "is a mapping of player to strategy" do
    @test_runner = GameRunner.new(game, [])
    @test_runner.set_players(players)
    @test_runner.players.keys.should == game.players
    @test_runner.players.values.each do |type|
      type.should respond_to(:get_move)
    end
  end

  describe "#take_turn" do
    before(:each) do
      @easy_ai = EasyAI
      @fake_ai = mock("FakeAI")
      runner.set_players([@easy_ai, @fake_ai])
    end

    it "takes a turn and stops when the game is over" do
      make_moves(game, [1, 4, 2, 5])
      @easy_ai.stub(:get_move).and_return(3)
      @fake_ai.should_not_receive(:request_move)
      runner.take_turn
    end

    it "takes a turn and repeats if the game is not over" do
      @fake_ai.should_receive(:request_move).with(runner)
      runner.take_turn
    end
  end

  it "makes the given move" do
    player = game.current_player
    runner.make_move(1)
    game.board.square(1).should == player
  end

  it "makes a move and takes another turn" do
    runner.should_receive(:take_turn)
    runner.make_move(1)
  end

  it "gets the current move source" do
    runner.current_move_source.should == runner.players[game.current_player]
  end
end
