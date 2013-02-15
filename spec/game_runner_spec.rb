require "game_runner"
require "easy_ai"

describe GameRunner do
  let(:game) { Game.tic_tac_toe }
  let(:players) { [EasyAI, EasyAI] }
  let(:runner) { GameRunner.new(game, players) }


  it "is a mapping of player to strategy" do
    runner.players.keys.should == game.players
    runner.players.values.each do |type|
      type.should respond_to(:get_move)
    end
  end

  it "takes turns until the game is over" do
    runner.take_turn
    game.game_over?.should == true
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
