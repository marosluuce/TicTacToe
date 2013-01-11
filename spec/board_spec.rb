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
      b.set_square(0, :x)
      b.squares[0].should == :x
    end
    it "only sets the value if the square is empty" do
      b.set_square(0, :x)
      b.set_square(0, :o).should eq(false) 
      b.squares[0].should == :x
    end
    it "returns false for an invalid index" do
      b.set_square(length * width, :x).should eq(false)
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
    it "returns [0,1,2,4,5,6,7,8] when 3 is taken" do
      b.set_square(3, :x)
      b.get_available_squares.should eq([0,1,2,4,5,6,7,8])
    end
  end

  describe "#to_s" do
    context "board with one square" do
      before(:each) do
        @t = Board.new(1,1)
      end

      it "returns a blank when the square is blank" do
        @t.to_s.should == " "
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

      it "returns ' | ' for two empty squares" do
        @t.to_s.should == " | "
      end

      it "returns \"x|o\" for [:x, :o]" do
        @t.set_square(0, :x)
        @t.set_square(1, :o)
        @t.to_s.should == "x|o"
      end
    end

    context "board with two sqoares in a column" do
      it "returns ' \\n---\\n '" do
        @t = Board.new(2, 1)
        @t.to_s.should == " \n---\n "
      end
    end

    context "board with n squares in a row" do
      it "works for 1x6 board" do
        @t = Board.new(1, 6)
        @t.to_s.should == " | | | | | "
      end
    end
  end
end
