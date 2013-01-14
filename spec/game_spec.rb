require "game"
require "player"
require "input"

describe Game do
  let(:g) { Game.new }

  it "has a tictactoe board" do
    g.board.length.should == 3
    g.board.width.should == 3
  end
  it "creates at least one player" do
    g.players.count.should > 1
    g.players.each do |p|
      p.should be_an_instance_of Player
    end
  end

  describe "#move" do
    it "gets the move" do
      g.should_receive(:get_move) { "1" }
      g.move
    end
    it "validates the move" do
      g.stub(:get_move) { "1" }
      g.should_receive(:validate_move) { true }
      g.move
    end
    it "does the move" do
      g.should_receive(:do_move)
      g.stub(:validate_move) { true }
      g.stub(:get_move) { "1" }
      g.move
    end
    it "loops until it gets valid input" do
      g.stub(:validate_move).and_return(false, true)
      g.stub(:get_move) { "1" }
      g.should_receive(:validate_move).twice
      g.move
    end
  end

  describe "#do_move" do
    it "makes a move" do
      g.do_move(1, :x)
      g.board.squares[0].should == :x
    end
    it "returns false for an invalid move" do
      g.do_move(9000, :x).should eq(false)
    end
  end

  describe "#get_move" do
    it "gets the current players move" do
      Input.stub(:get_console_input) { "1" } 
      Input.should_receive(:get_console_input) { "1" }
      g.get_move.should == "1"
    end
  end

  describe "#validate_move" do
    it "gets the available squares from the board" do
      g.board.should_receive(:get_available_squares) { [1, 2] }
      g.validate_move("1")
    end
    it "returns false if move is not a number" do
      g.validate_move("a").should eq(false)
    end
    it "returns true when move is in the available squares" do
      g.validate_move("1").should eq(true)
    end
  end

  describe "#run" do
    it "calls the move, update, and draw in order" do
      g.should_receive(:move).ordered
      g.should_receive(:update).ordered
      g.should_receive(:draw).ordered
      g.run
    end
  end

  describe "#update" do
    it "rotates the players after every move" do
      player_one = g.players.first
      g.update
      g.players.last.should == player_one
    end
  end
end
