require "spec_helper"
require "board"

describe Board do
  let(:length) { 3 }
  let(:width) { 3 }
  let(:b) { Board.new(length, width) }

  it "creates a board" do
    b.should be_an_instance_of Board
  end
  it "has a width" do
    b.width.should == 3
  end
  it "has a height" do
      b.width.should == 3
  end
  it "has squares which is an array" do
    b.squares.should be_an_instance_of Array
  end
  it "has squares with length equal to length * width" do
    b.squares.count.should == length * width
  end

  describe "#set_square" do
    it "sets the square to value" do
      b.set_square(1, :x)
      b.squares[0].should == :x
    end
    it "only sets the value if the square is empty" do
      b.set_square(1, :x)
      b.set_square(1, :o).should eq(false) 
      b.squares[0].should == :x
    end
    it "returns false for an invalid index" do
      b.set_square(length * width + 1, :x).should eq(false)
    end
  end

  describe "self.tic_tac_toe" do
    it "returns a 3x3 board" do
      t = Board.tic_tac_toe
      t.squares.count.should == 9
    end
  end

  describe "#get_available_squares" do
    it "returns [] when squares are full" do
      fill_board_with_symbol(b, :x)
      b.get_available_squares.should eq([])
    end
    it "returns [1,2,4,5,6,7,8,9] when 3 is taken" do
      b.set_square(3, :x)
      b.get_available_squares.should eq([1,2,4,5,6,7,8,9])
    end
  end

  describe "#to_s" do
    context "board with one square" do
      before(:each) do
        @t = Board.new(1,1)
      end

      it "returns the square choice when the square is blank" do
        @t.to_s.should == "1"
      end
      it "returns the value when the square has a value" do
        @t.set_square(0, :x)
        @t.to_s.should == "x"
      end
    end

    context "board with two squares |_|_|" do
      before(:each) do
        @t = Board.new(1, 2)
      end

      it "returns '1|2' for two empty squares" do
        @t.to_s.should == "1|2"
      end

      it "returns \"x|o\" for [:x, :o]" do
        @t.set_square(1, :x)
        @t.set_square(2, :o)
        @t.to_s.should == "x|o"
      end
    end

    context "board with two squares in a column" do
      it "returns '1\\n---\\n2'" do
        @t = Board.new(2, 1)
        @t.to_s.should == "1\n-\n2"
      end
    end

    context "board with n squares" do
      it "works for 1x6 board" do
        @t = Board.new(1, 6)
        @t.to_s.should == "1|2|3|4|5|6"
      end
      it "works for 3x3 board" do
        @t = Board.new(3, 3)
        @t.to_s.should == "1|2|3\n-----\n4|5|6\n-----\n7|8|9"
      end
    end
  end

  describe "#full?" do
    it "returns false when all squares are empty" do
      b.full?.should eq(false)
    end
    it "returns false when some squares are full" do
      b.set_square(1, :x)
      b.full?.should eq(false)
    end
    it "returns true when all squares are full" do
      fill_board_with_symbol(b, :x)
      b.full?.should eq(true)
    end
  end

  describe "#game_over?" do
    it "returns false when board is not full" do
      b.game_over?.should eq(false)
    end
    it "returns true when board is full" do
      fill_board_with_symbol(b, :x)
      b.game_over?.should eq(true)
    end
    it "returns true when the first row contains the same symbol" do
      (1..width).each { |n| b.set_square(n, :x) }
      b.game_over?.should eq(true)
    end
  end
end
