require "spec_helper"
require "board"
require "rules"

describe Rules do
  let(:board) { Board.tic_tac_toe }
  let(:rules) { Rules.new(board) }

  describe "#draw?" do
    it "is false if board is not full" do
      rules.draw?.should == board.full?
    end
    it "is false if there is a winner" do
      set_board_to_array(board, [:x, :x, :x, nil, nil, nil, nil, nil, nil])
      rules.draw?.should eq(false)
    end
    it "is true if there is no winner and the board is full" do
      set_board_to_draw_state(board)
      rules.draw?.should eq(true)
    end
  end

  describe "#game_over?" do
    it "returns false when board is empty" do
      rules.game_over?.should eq(false)
    end
    it "returns true when board is full" do
      set_board_to_draw_state(board)
      rules.game_over?.should eq(true)
    end
    it "returns true when winner is not nil" do
      fill_board_with_symbol(board, :x)
      rules.game_over?.should eq(true)
    end
  end

  describe "#winner" do
    it "returns nil if no winner is found" do
      rules.winner.should == nil
    end
    it "returns the symbol when the first row contains the same symbol" do
      set_board_to_array(board, [:x, :x, :x, nil, nil, nil, nil, nil, nil])
      rules.winner.should == :x
    end
    it "returns the symbol when the last row contains the same symbol" do
      set_board_to_array(board, [nil, nil, nil, nil, nil, nil, :x, :x, :x])
      rules.winner.should == :x
    end
    it "returns the symbol when the first column contains the same symbol" do
      set_board_to_array(board, [:x, nil, nil, :x, nil, nil, :x, nil, nil])
      rules.winner.should == :x
    end
    it "returns the symbol when the last column contains the same symbol" do
      set_board_to_array(board, [nil, nil, :x, nil, nil, :x, nil, nil, :x])
      rules.winner.should == :x
    end
    it "returns the symbol when the left diag contains the same symbol" do
      set_board_to_array(board, [:x, nil, nil, nil, :x, nil, nil, nil, :x])
      rules.winner.should == :x
    end
    it "returns the symbol when the right diag contains the same symbol" do
      set_board_to_array(board, [nil, nil, :x, nil, :x, nil, :x, nil, nil])
      rules.winner.should == :x
    end
    it "returns nil when row does not contain the same symbols" do
      set_board_to_array(board, [:x, :o, :x, nil, nil, nil, nil, nil, nil])
      rules.winner.should be_nil
    end
    it "returns nil when a col does not contain the same symbols" do
      set_board_to_array(board, [:x, nil, nil, :o, nil, nil, :x, nil, nil])
      rules.winner.should be_nil
    end
    it "returns nil when the left diag does not contain the same symbol" do
      set_board_to_array(board, [:x, nil, nil, nil, :o, nil, nil, nil, :x])
      rules.winner.should be_nil
    end
    it "returns nil when the right diag does not contain the same symbol" do
      set_board_to_array(board, [nil, nil, :x, nil, :o, nil, :x, nil, nil])
      rules.winner.should be_nil
    end
  end
end

#class MockPlayer
  #def initialize(board)
    #@board = board
  #end

  #def get_move
    #@board.available_moves.first
  #end
#end
