require "game"
require "player"
require "input"
require "input_strategy"
require "display"

describe Game do
  let(:board) { Board.tic_tac_toe }
  let(:game) { Game.new([Player.new(:x, board), Player.new(:o, board)], board) }

  before(:each) do
    Display.stub(:display)
  end

  it "has a tictactoe board" do
    game.board.length.should == 3
    game.board.width.should == 3
  end
  it "creates at least one player" do
    game.players.count.should > 1
  end

  describe "#move" do
    before(:each) do
      game.stub(:get_move) { "1" }
    end

    it "gets the move" do
      game.should_receive(:get_move) { "1" }
      game.move
    end
    it "validates the move" do
      game.should_receive(:validate_move) { true }
      game.move
    end
    it "does the move" do
      game.move
      game.board.squares[0].should_not be_nil
    end
    it "loops until it gets valid input" do
      Input.stub(:request_move) { "a" "1" }
      game.move
    end
  end

  describe "#do_move" do
    it "makes a move" do
      game.do_move(1, :x)
      game.board.squares[0].should == :x
    end
  end

  describe "#get_move" do
    it "gets the current players move" do
      game.players.first.should_receive(:get_move)
      game.get_move
    end
  end

  describe "#validate_move" do
    it "gets the available squares from the board" do
      game.board.should_receive(:available_squares) { [1, 2] }
      game.validate_move("1")
    end
    it "returns false if move is not a number" do
      game.validate_move("a").should eq(false)
    end
    it "returns true when move is in the available squares" do
      game.validate_move("1").should eq(true)
    end
  end

  describe "#request_move" do
    it "calls Input.request_move" do
      Input.should_receive(:request_move)
      game.request_move
    end
  end

  describe "#turn" do
    it "calls the move, update, and draw in order" do
      game.should_receive(:move).ordered
      game.should_receive(:update).ordered
      game.should_receive(:draw).ordered
      game.turn
    end
  end

  describe "#run" do
    it "is game over after the function runs" do
      Input.stub(:request_move) { game.board.available_squares.first }
      Display.stub(:display)
      game.run
      game.board.game_over?.should eq(true)
    end
  end

  describe "#update" do
    it "rotates the players after every move" do
      player_one = game.players.first
      game.update
      game.players.last.should == player_one
    end
  end

  describe "#draw" do
    it "draws something" do
      Display.should_receive(:display).at_least(:once)
      game.draw
    end
  end
end
