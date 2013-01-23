require "ai"
require "board"
require "spec_helper"

describe AI do
  let(:b) { Board.new(3, 3) }
  let(:sym) { :o }
  let(:opponent_sym) { :x }
  let(:ai) { AI.new(sym, opponent_sym, b) }

  it "returns the correct symbol" do
    ai.sym.should == sym
  end

  describe "#get_move" do
    it "picks a valid move" do
      b.available_squares.should include(ai.get_move)
    end
    it "is a win for [x,o,x,o,o,_,x,x,_]" do
      set_board_to_array(b, [:x, :o, :x, :o, :o, nil, :x, :x, nil])
      ai.get_move.should == 6
    end
    it "is a win for [x,_,x,_,o,x,_,o,o]" do
      set_board_to_array(b, [:x, nil, :x, nil, :o, :x, nil, :o, :o])
      [2, 7].should include(ai.get_move)
    end
    it "is a win and not a block for [x,_,x,_,x,_,o,_,o]" do
      set_board_to_array(b, [:x, nil, :x,  nil, :x, nil, :o, nil, :o])
      ai.get_move.should == 8
    end
    it "is a block for [x,o,x,o,x,x,o,_,_]" do
      set_board_to_array(b, [:x, :o, :x, :o, :x, :x, :o, nil, nil])
      ai.get_move.should == 9
    end
    it "takes a win [x,x,o,_,o,_,_,x,_]" do
      set_board_to_array(b, [:x, :x, :o, nil, :o, nil, nil, :x, nil])
      ai.get_move.should == 7
    end
    it "is blocks a fork [x,_,_,_,o,_,_,_,x]" do
      set_board_to_array(b, [:x, nil, nil, nil, :o, nil, nil, nil, :x])
      [3, 7].should_not include(ai.get_move)
    end
    it "is the center if unclaimed" do
      ai.get_move.should == 5
    end
    it "is a corner for [_,_,_,_,x,_,_,_,_]" do
      b.set_square(5, :x)
      [1, 3, 7, 9].should include(ai.get_move)
    end
  end
end
