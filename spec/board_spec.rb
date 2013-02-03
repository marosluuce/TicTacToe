require "spec_helper"
require "board"

describe Board do
  let(:width) { 3 }
  let(:length) { 3 }
  let(:board) { Board.new(length, width) }

  it "has squares with length equal to length * width" do
    board.squares.count.should == length * width
  end

  describe "#set_square" do
    it "sets the square to value" do
      board.set_square(1, :x)
      board.squares[0].should == :x
    end
  end

  describe "self.tic_tac_toe" do
    it "returns a 3x3 board" do
      ttt_board = Board.tic_tac_toe
      ttt_board.squares.count.should == 9
    end
  end

  describe "#available_squares" do
    it "returns [] when squares are full" do
      fill_board_with_symbol(board, :x)
      board.available_squares.should eq([])
    end
    it "returns [1,2,4,5,6,7,8,9] when 3 is taken" do
      board.set_square(3, :x)
      board.available_squares.should eq([1, 2, 4, 5, 6, 7, 8, 9])
    end
  end

  describe "#full?" do
    it "returns false when all squares are empty" do
      board.full?.should eq(false)
    end
    it "returns false when some squares are full" do
      board.set_square(1, :x)
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
      board.set_square(1, :x)
      board.empty?.should be_false
    end
  end
end
