require "game"
require "player"
require "input"
require "display"

describe Game do
  let(:g) { Game.new }

  it "has a tictactoe board" do
    g.board.length.should == 3
    g.board.width.should == 3
  end
  it "creates at least one player" do
    g.players.count.should > 1
  end

  describe "#move" do
    before(:each) do
      g.stub(:get_move) { "1" }
    end

    it "gets the move" do
      g.should_receive(:get_move) { "1" }
      g.move
    end
    it "validates the move" do
      g.should_receive(:validate_move) { true }
      g.move
    end
    it "does the move" do
      g.should_receive(:do_move).with("1", :x)
      g.stub(:validate_move) { true }
      g.move
    end
    it "loops until it gets valid input" do
      g.stub(:validate_move).and_return(false, true)
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
      g.players.first.should_receive(:get_move)
      g.get_move
    end
  end

  describe "#validate_move" do
    it "gets the available squares from the board" do
      g.board.should_receive(:available_squares) { [1, 2] }
      g.validate_move("1")
    end
    it "returns false if move is not a number" do
      g.validate_move("a").should eq(false)
    end
    it "returns true when move is in the available squares" do
      g.validate_move("1").should eq(true)
    end
  end

  describe "#request_move" do
    it "calls Input.request_move" do
      Input.should_receive(:request_move)
      g.request_move
    end
  end

  describe "#turn" do
    it "calls the move, update, and draw in order" do
      g.should_receive(:move).ordered
      g.should_receive(:update).ordered
      g.should_receive(:draw).ordered
      g.turn
    end
  end

  describe "#run" do
    it "is game over after the function runs" do
      g.stub(:get_move) { g.board.available_squares.first }
      Display.stub(:display)
      g.run
      g.board.game_over?.should eq(true)
    end
  end

  describe "#update" do
    it "rotates the players after every move" do
      player_one = g.players.first
      g.update
      g.players.last.should == player_one
    end
  end

  describe "#draw" do
    it "prints the board" do
      Display.should_receive(:display).with(g.board)
      g.draw
    end
  end
end
