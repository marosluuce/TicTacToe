require "spec_helper"
require "game"
require "board"
require "rules"

describe Game do
  let(:board) { Board.new(3, 3) }
  let(:rules) { Rules.new(board) }
  let(:players) { [:x, :o] }
  let(:game) { Game.new(board, rules, players) }

  it "is a tic tac toe game" do
    ttt = Game.tic_tac_toe
    ttt.should be_an_instance_of Game
    ttt.board.width.should == 3
    ttt.board.length.should == 3
    ttt.players.count.should == 2
  end

  it "makes a move" do
    game.make_move(1)
    board.square(1).should == players.first
  end

  it "does not update the history for an invalid move" do
    game.make_move(-1)
    game.move_history.count.should == 0
  end

  it "does not make an invalid move" do
    count = board.size
    game.make_move(-10)
    board.size.should == count
  end

  it "checks if the game is over" do
    game.game_over?.should == rules.game_over?
  end

  it "gets the current player" do
    game.current_player.should == players.first
  end

  it "gets the winner" do
    game.winner.should == rules.winner
  end

  it "is nil when no moves have been made" do
    game.last_move.should == nil
  end

  it "is the latest move when a move has been made" do
    game.make_move(1)
    game.last_move.should == 1
  end

  it "undoes the last move" do
    game.make_move(1)
    game.undo_last_move
    game.last_move.should be_nil
    board.squares[0].should be_nil
  end

  it "is true for a valid move" do
    game.valid_move?(1).should eq(true)
  end

  it "is false for an invalid move" do
    game.valid_move?(-1).should eq(false)
    game.valid_move?(board.size + 1).should eq(false)
  end
end
