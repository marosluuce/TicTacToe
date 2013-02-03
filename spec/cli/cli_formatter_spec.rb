require "cli/cli_formatter.rb"
require "board"
require "player"

describe CliFormatter do
  let (:player) { Player.new(:x) }

  describe "#self.format_board" do
    context "board with one square" do
      before(:each) do
        @one_board = Board.new(1,1)
      end

      it "returns the square choice when the square is blank" do
        CliFormatter.board(@one_board).should == "1"
      end

      it "returns the value when the square has a value" do
        @one_board.set_square(1, :x)
        CliFormatter.board(@one_board).should == "x"
      end
    end

    context "board with two squares |_|_|" do
      before(:each) do
        @two_board = Board.new(1, 2)
      end

      it "returns '1|2' for two empty squares" do
        CliFormatter.board(@two_board).should == "1|2"
      end

      it "returns \"x|o\" for [:x, :o]" do
        @two_board.set_square(1, :x)
        @two_board.set_square(2, :o)
        CliFormatter.board(@two_board).should == "x|o"
      end
    end

    context "board with two squares in a column" do
      it "returns '1\\n---\\n2'" do
        two_board = Board.new(2, 1)
        CliFormatter.board(two_board).should == "1\n-\n2"
      end
    end

    context "board with n squares" do
      it "works for 1x6 board" do
        long_board = Board.new(1, 6)
        CliFormatter.board(long_board).should == "1|2|3|4|5|6"
      end
      it "works for 3x3 board" do
        ttt_board = Board.new(3, 3)
        CliFormatter.board(ttt_board).should == "1|2|3\n-----\n4|5|6\n-----\n7|8|9"
      end
    end
  end

  describe "#current_player" do
    it "is a string with the player" do
      CliFormatter.current_player(player).should == "X's Turn!"
    end
  end

  describe "#self.last_move" do
    it "is a string with the last move" do
      CliFormatter.last_move(5).should == "Last Move: 5"
    end

    it "is nil when the last move is nil" do
      CliFormatter.last_move(nil).should == nil
    end
  end

  describe "#self.winner" do
    it "is a string with the winner if there was one" do
      CliFormatter.winner(player).should == "X Won!"
    end

    it "is a string with draw if there was no winner" do
      CliFormatter.winner(nil).should == "Draw!"
    end
  end

  describe "#format_player_choices" do
    it "is a string with the choices on different lines" do
      choices = ["Human", "AI"]
      CliFormatter.player_choices(choices).should == "1. Human\n2. AI\n"
    end
  end
end
