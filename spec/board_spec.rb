require "spec_helper"
require "board"

describe Board do
  let(:width) { 3 }
  let(:length) { 3 }
  let(:board) { Board.new(length, width) }

  it "has squares with length equal to length * width" do
    board.size.should == length * width
  end

  it "is the number of squares" do
    board.size.should == 9
  end

  it "is the value of the square" do
    board.make_move(1, :x)
    board.square(1).should == :x
  end

  it "sets the square to value" do
    board.make_move(1, :x)
    board.square(1).should == :x
  end

  it "sets a square to nil" do
    board.make_move(1, :x)
    board.undo_move(1)
    board.square(1).should be_nil
  end

  it "returns a 3x3 board" do
    ttt_board = Board.tic_tac_toe
    ttt_board.size.should == 9
  end

  describe "#available_moves" do
    it "returns [] when squares are full" do
      fill_board_with_symbol(board, :x)
      board.available_moves.should eq([])
    end
    it "returns [1,2,4,5,6,7,8,9] when 3 is taken" do
      board.make_move(3, :x)
      board.available_moves.should eq([1, 2, 4, 5, 6, 7, 8, 9])
    end
  end

  describe "#full?" do
    it "returns false when all squares are empty" do
      board.full?.should eq(false)
    end

    it "returns false when some squares are full" do
      board.make_move(1, :x)
      board.full?.should eq(false)
    end

    it "returns true when all squares are full" do
      fill_board_with_symbol(board, :x)
      board.full?.should eq(true)
    end
  end

  describe "#empty?" do
    it "is true when empty" do
      board.empty?.should be_true
    end

    it "is false when not empty" do
      board.make_move(1, :x)
      board.empty?.should be_false
    end
  end
end
