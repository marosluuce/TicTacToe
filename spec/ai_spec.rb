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
    it "picks the middle if board is empty" do
      ai.get_move.should == 5
    end
  end

  describe "#score_board" do
    it "is nil when game is not over" do
      ai.score_board(Board.tic_tac_toe).should be_nil
    end
    it "is 0 when the game is a draw" do
      set_board_to_draw_state(b)
      ai.score_board(b).should == 0
    end
    it "is 1 when the ai wins" do
      fill_board_with_symbol(b, sym)
      ai.score_board(b).should == 1
    end
    it "is -1 when the ai does not win" do
      fill_board_with_symbol(b, :x)
      b.squares.first.should_not == sym
      ai.score_board(b).should == -1
    end
  end

  describe "#select_move" do
    it "picks the highest value" do
      sample = {1 => 0, 2 => -1, 3 => 1, 4 => -1}
      ai.select_move(sample).should == 3
    end
  end

  describe "#run_negamax" do
    it "is a win for [x,o,x,o,o,_,x,x,_]" do
      set_board_to_array(b, [:x, :o, :x, :o, :o, nil, :x, :x, nil])
      moves = ai.run_negamax(b)
      moves[6].should == 1
    end
    it "is a win for [x,_,x,_,o,x,_,o,o]" do
      set_board_to_array(b, [:x, nil, :x, nil, :o, :x, nil, :o, :o])
      moves = ai.run_negamax(b)
      moves[2].should == 1
      moves[7].should == 1
    end
    it "is a win and not a block for [x,_,x,_x,_,_,o,_,o]" do
      set_board_to_array(b, [:x, nil, :x, :x, nil, nil, :o, nil, :o])
      moves = ai.run_negamax(b)
      moves[8].should == 1
    end
    it "is a block for [x,o,x,o,x,x,o,_,_]" do
      set_board_to_array(b, [:x, :o, :x, :o, :x, :x, :o, nil, nil])
      moves = ai.run_negamax(b)
      moves[9].should > moves[8]
    end
    it "takes a win [x,x,o,_,o,_,_,x,_]" do
      set_board_to_array(b, [:x, :x, :o, nil, :o, nil, nil, :x, nil])
      moves = ai.run_negamax(b)
      moves[6].should == "FIX ME"
    end
    it "is blocks a fork [x,_,_,_,o,_,_,_,x]" do
      set_board_to_array(b, [:x, nil, nil, nil, :o, nil, nil, nil, :x])
      moves = ai.run_negamax(b)
      moves[3].should == -1
      moves[7].should == -1
    end
    it "is the center for a [x,_,_,_,_,_,_,_,_,_]" do
      b.set_square(1, :x)
      moves = ai.run_negamax(b)
      moves.max_by { |k, v| v }.first.should == 5
    end
    it "is a corner for [_,_,_,_,x,_,_,_,_]" do
      b.set_square(5, :x)
      moves = ai.run_negamax(b)
      max_value = moves.max_by { |k, v| v }.last
      moves.select { |k, v| v == max_value }.keys.should == [1, 3, 7, 9]
    end
  end
end
