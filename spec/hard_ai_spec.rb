require "hard_ai"
require "board"
require "game"
require "spec_helper"

describe HardAI do
  let(:game) { Game.tic_tac_toe }

  describe "#get_move" do
    it "picks a valid move" do
      game.board.available_moves.should include(HardAI.get_move(game))
    end
    it "is a win for [x,o,x,o,o,_,x,x,_]" do
      make_moves(game, [1, 2, 3, 4, 7, 5, 8])
      HardAI.get_move(game).should == 6
    end
    it "is a win for [x,_,x,_,o,x,_,o,o]" do
      make_moves(game, [1, 9, 3, 5, 8, 6])
      [2, 7].should include(HardAI.get_move(game))
    end
    it "is a win and not a block for [x,_,x,_,x,_,o,_,o]" do
      make_moves(game, [1, 9, 3, 7, 5])
      HardAI.get_move(game).should == 8
    end
    it "is a block for [x,o,x,o,x,x,o,_,_]" do
      make_moves(game, [1, 2, 3, 4, 5, 7, 6])
      HardAI.get_move(game).should == 9
    end
    it "takes a win [x,x,o,_,o,_,_,x,_]" do
      make_moves(game, [1, 3, 2, 5, 8])
      HardAI.get_move(game).should == 7
    end
    it "is blocks a fork [x,_,_,_,o,_,_,_,x]" do
      make_moves(game, [1, 5, 9])
      [3, 7].should_not include(HardAI.get_move(game))
    end
    it "is the center if unclaimed" do
      HardAI.get_move(game).should == 5
    end
    it "is a corner for [_,_,_,_,x,_,_,_,_]" do
      game.make_move(5)
      [1, 3, 7, 9].should include(HardAI.get_move(game))
    end
  end
end
