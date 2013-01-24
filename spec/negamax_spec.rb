require "negamax"
require "board"
require "spec_helper"

describe Negamax do
  let(:board) { Board.tic_tac_toe }
  let(:negamax) { Negamax.new([:x, :o], board) }

  describe "#get_move" do
    it "picks a valid move" do
      board.available_squares.should include(negamax.get_move(:o))
    end
    it "is a win for [x,o,x,o,o,_,x,x,_]" do
      set_board_to_array(board, [:x, :o, :x, :o, :o, nil, :x, :x, nil])
      negamax.get_move(:o).should == 6
    end
    it "is a win for [x,_,x,_,o,x,_,o,o]" do
      set_board_to_array(board, [:x, nil, :x, nil, :o, :x, nil, :o, :o])
      [2, 7].should include(negamax.get_move(:o))
    end
    it "is a win and not a block for [x,_,x,_,x,_,o,_,o]" do
      set_board_to_array(board, [:x, nil, :x,  nil, :x, nil, :o, nil, :o])
      negamax.get_move(:o).should == 8
    end
    it "is a block for [x,o,x,o,x,x,o,_,_]" do
      set_board_to_array(board, [:x, :o, :x, :o, :x, :x, :o, nil, nil])
      negamax.get_move(:o).should == 9
    end
    it "takes a win [x,x,o,_,o,_,_,x,_]" do
      set_board_to_array(board, [:x, :x, :o, nil, :o, nil, nil, :x, nil])
      negamax.get_move(:o).should == 7
    end
    it "is blocks a fork [x,_,_,_,o,_,_,_,x]" do
      set_board_to_array(board, [:x, nil, nil, nil, :o, nil, nil, nil, :x])
      [3, 7].should_not include(negamax.get_move(:o))
    end
    it "is the center if unclaimed" do
      negamax.get_move(:o).should == 5
    end
    it "is a corner for [_,_,_,_,x,_,_,_,_]" do
      board.set_square(5, :x)
      [1, 3, 7, 9].should include(negamax.get_move(:o))
    end
  end
end
