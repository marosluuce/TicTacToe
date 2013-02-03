require "spec_helper"
require "game_runner"
require "game_builder"

describe GameRunner do
  let(:game) { GameBuilder.build([3, 3]) }
  let(:runner) { GameRunner.new(game) }

  it "gets the board from the game" do
    runner.board.should be_an_instance_of Board
  end

  it "makes a move" do
    runner.do_move(1)
    runner.board.squares[0].should == runner.game.players.first
  end

  describe "#validate_move" do
    it "gets the available squares from the board" do
      runner.board.should_receive(:available_squares) { [1, 2] }
      runner.validate_move("1")
    end
    it "returns false if move is not a number" do
      runner.validate_move("a").should eq(false)
    end
    it "returns true when move is in the available squares" do
      runner.validate_move("1").should eq(true)
    end
  end

  it "gets the game's last move" do
    runner.last_move.should == game.last_move
  end

  it "checks if the game is over" do
    runner.game_over?.should == game.game_over?
  end

  it "gets the current player" do
    runner.current_player.should == game.current_player
  end

  it "gets the winner" do
    runner.winner.should == game.winner
  end
end
