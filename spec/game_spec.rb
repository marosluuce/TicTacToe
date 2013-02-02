require "spec_helper"
require "board"
require "game"
require "uiwrapper"
require "stringio"

describe Game do
  let(:board) { Board.tic_tac_toe }
  let(:player1) { "fake_player1" }
  let(:player2) { "fake_player2"}
  let(:io) { UIWrapper.new(StringIO.new) }
  let(:game) { Game.new([player1, player2], board, io) }

  before(:each) do
    player1.stub(:get_move) { board.available_squares.first }
    player2.stub(:get_move) { board.available_squares.first }
  end

  it "has a tictactoe board" do
    game.board.squares.count.should == 9
    game.board.width.should == 3
  end
  it "creates at least one player" do
    game.players.count.should > 1
  end

  describe "#move" do
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

  describe "#turn" do
  end

  describe "#run" do
    it "is game over after the function runs" do
      game.run
      game.game_over?.should eq(true)
    end
  end

  describe "#current_player" do
    it "is the first player on the first turn" do
      game.current_player.should == game.players.first
    end

    it "is the second player on the second turn" do
      game.do_move(1, game.players.first)
      game.current_player.should == game.players.last
    end

    it "is the first player on the third turn" do
      set_board_to_array(board, [:x, :o, nil, nil, nil, nil, nil, nil, nil])
      game.current_player.should == game.players.first
    end
  end

  describe "#draw" do
    it "draws something" do
      io.should_receive(:puts).at_least(:once)
      game.draw
    end
  end

  describe "#draw?" do
    it "is false if board is not full" do
      game.draw?.should == board.full?
    end
    it "is false if there is a winner" do
      set_board_to_array(board, [:x, :x, :x, nil, nil, nil, nil, nil, nil])
      game.draw?.should eq(false)
    end
    it "is true if there is no winner and the board is full" do
      set_board_to_draw_state(board)
      game.draw?.should eq(true)
    end
  end

  describe "#game_over?" do
    it "returns false when board is empty" do
      game.game_over?.should eq(false)
    end
    it "returns true when board is full" do
      set_board_to_draw_state(board)
      game.game_over?.should eq(true)
    end
    it "returns true when winner is not nil" do
      fill_board_with_symbol(board, :x)
      game.game_over?.should eq(true)
    end
  end

  describe "#winner" do
    it "returns nil if no winner is found" do
      game.winner.should == nil
    end
    it "returns the symbol when the first row contains the same symbol" do
      set_board_to_array(board, [:x, :x, :x, nil, nil, nil, nil, nil, nil])
      game.winner.should == :x
    end
    it "returns the symbol when the last row contains the same symbol" do
      set_board_to_array(board, [nil, nil, nil, nil, nil, nil, :x, :x, :x])
      game.winner.should == :x
    end
    it "returns the symbol when the first column contains the same symbol" do
      set_board_to_array(board, [:x, nil, nil, :x, nil, nil, :x, nil, nil])
      game.winner.should == :x
    end
    it "returns the symbol when the last column contains the same symbol" do
      set_board_to_array(board, [nil, nil, :x, nil, nil, :x, nil, nil, :x])
      game.winner.should == :x
    end
    it "returns the symbol when the left diag contains the same symbol" do
      set_board_to_array(board, [:x, nil, nil, nil, :x, nil, nil, nil, :x])
      game.winner.should == :x
    end
    it "returns the symbol when the right diag contains the same symbol" do
      set_board_to_array(board, [nil, nil, :x, nil, :x, nil, :x, nil, nil])
      game.winner.should == :x
    end
    it "returns nil when row does not contain the same symbols" do
      set_board_to_array(board, [:x, :o, :x, nil, nil, nil, nil, nil, nil])
      game.winner.should be_nil
    end
    it "returns nil when a col does not contain the same symbols" do
      set_board_to_array(board, [:x, nil, nil, :o, nil, nil, :x, nil, nil])
      game.winner.should be_nil
    end
    it "returns nil when the left diag does not contain the same symbol" do
      set_board_to_array(board, [:x, nil, nil, nil, :o, nil, nil, nil, :x])
      game.winner.should be_nil
    end
    it "returns nil when the right diag does not contain the same symbol" do
      set_board_to_array(board, [nil, nil, :x, nil, :o, nil, :x, nil, nil])
      game.winner.should be_nil
    end
  end

end
