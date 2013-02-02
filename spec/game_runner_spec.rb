require "spec_helper"
require "game_runner"
require "board"
require "uiwrapper"
require "game"
require "player"
require "dumb_strategy"
require "stringio"

describe GameRunner do
  let(:board) { Board.tic_tac_toe }
  let(:ui) { UIWrapper.new(StringIO.new) }
  let(:strategy) { DumbStrategy.new(nil, board, nil) }
  let(:player1) { Player.new(:x, strategy) }
  let(:player2) { Player.new(:o, strategy) }
  let(:game) { Game.new([player1, player2], board, ui) }
  let(:runner) { GameRunner.new(game) }

  it "gets the board from the game" do
    runner.board.should == board
  end

  it "is true if the game is over" do
    fill_board_with_symbol(board, :x)
    runner.game_over?.should eq(true)
  end

  it "is false if the game is not over" do
    runner.game_over?.should eq(false)
  end
end
