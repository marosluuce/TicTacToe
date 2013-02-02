require "spec_helper"
require "board"

describe Board do
  let(:width) { 3 }
  let(:length) { 3 }
  let(:board) { Board.new(length, width) }

  it "creates a board" do
    board.should be_an_instance_of Board
  end
  it "has a width" do
    board.width.should == 3
  end
  it "has squares which is an array" do
    board.squares.should be_an_instance_of Array
  end
  it "has squares with length equal to length * width" do
    board.squares.count.should == length * width
  end

  describe "#set_square" do
    it "sets the square to value" do
      board.set_square(1, :x)
      board.squares[0].should == :x
    end
    it "remembers the last square played" do
      board.set_square(1, :x)
      board.last_move.should == 1
    end
  end

  describe "#set_square_nil" do
    it "sets a square to nil" do
      board.set_square(5, :x)
      board.set_square_nil(5)
      board.squares[4].should == nil
    end
    it "sets last_move to nil" do
      board.set_square(1, :x)
      board.set_square_nil(1)
      board.last_move.should_not == 1
      board.last_move.should be_nil
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
      board.available_squares.should eq([1,2,4,5,6,7,8,9])
    end
  end

  describe "#to_s" do
    context "board with one square" do
      before(:each) do
        @one_board = Board.new(1,1)
      end

      it "returns the square choice when the square is blank" do
        @one_board.to_s.should == "1"
      end
      it "returns the value when the square has a value" do
        @one_board.set_square(1, :x)
        @one_board.to_s.should == "x"
      end
    end

    context "board with two squares |_|_|" do
      before(:each) do
        @two_board = Board.new(1, 2)
      end

      it "returns '1|2' for two empty squares" do
        @two_board.to_s.should == "1|2"
      end

      it "returns \"x|o\" for [:x, :o]" do
        @two_board.set_square(1, :x)
        @two_board.set_square(2, :o)
        @two_board.to_s.should == "x|o"
      end
    end

    context "board with two squares in a column" do
      it "returns '1\\n---\\n2'" do
        two_board = Board.new(2, 1)
        two_board.to_s.should == "1\n-\n2"
      end
    end

    context "board with n squares" do
      it "works for 1x6 board" do
        long_board = Board.new(1, 6)
        long_board.to_s.should == "1|2|3|4|5|6"
      end
      it "works for 3x3 board" do
        ttt_board = Board.new(3, 3)
        ttt_board.to_s.should == "1|2|3\n-----\n4|5|6\n-----\n7|8|9"
      end
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
