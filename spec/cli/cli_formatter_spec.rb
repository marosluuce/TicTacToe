require "cli/cli_formatter.rb"
require "board"

describe CliFormatter do
  describe "#self.format_board" do
    context "board with one square" do
      before(:each) do
        @one_board = Board.new(1,1)
      end

      it "returns the square choice when the square is blank" do
        CliFormatter.format_board(@one_board).should == "1"
      end

      it "returns the value when the square has a value" do
        @one_board.set_square(1, :x)
        CliFormatter.format_board(@one_board).should == "x"
      end
    end

    context "board with two squares |_|_|" do
      before(:each) do
        @two_board = Board.new(1, 2)
      end

      it "returns '1|2' for two empty squares" do
        CliFormatter.format_board(@two_board).should == "1|2"
      end

      it "returns \"x|o\" for [:x, :o]" do
        @two_board.set_square(1, :x)
        @two_board.set_square(2, :o)
        CliFormatter.format_board(@two_board).should == "x|o"
      end
    end

    context "board with two squares in a column" do
      it "returns '1\\n---\\n2'" do
        two_board = Board.new(2, 1)
        CliFormatter.format_board(two_board).should == "1\n-\n2"
      end
    end

    context "board with n squares" do
      it "works for 1x6 board" do
        long_board = Board.new(1, 6)
        CliFormatter.format_board(long_board).should == "1|2|3|4|5|6"
      end
      it "works for 3x3 board" do
        ttt_board = Board.new(3, 3)
        CliFormatter.format_board(ttt_board).should == "1|2|3\n-----\n4|5|6\n-----\n7|8|9"
      end
    end
  end
end
