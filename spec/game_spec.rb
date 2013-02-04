require "spec_helper"
require "board"
require "game"

describe Game do
  let(:board) { Board.tic_tac_toe }
  let(:player1) { "fake_player1" }
  let(:player2) { "fake_player2"}
  let(:config) { {:board => board, :players => [player1, player2]} }
  let(:game) { Game.new.load_config(config) }

  before(:each) do
    player1.stub(:get_move) { board.available_squares.first }
    player2.stub(:get_move) { board.available_squares.first }
  end

  it "has a tictactoe board" do
    game.board.squares.count.should == 9
    game.board.width.should == 3
  end

  it "is nil when no moves have been made" do
    game.last_move.should == nil
  end

  it "is the latest move when there are moves" do
    game.do_move(1)
    game.last_move.should == 1
  end

  it "undoes the last move" do
    game.do_move(1)
    game.undo_last_move
    game.last_move.should be_nil
    game.board.squares[0].should be_nil
  end

  it "makes a move" do
    game.do_move(1)
    game.board.squares[0].should == player1
  end

  it "does not make a move when the square if filled" do
    game.do_move(1)
    game.do_move(1)
    game.move_history.count.should == 1
  end

  describe "#current_player" do
    it "is the first player on the first turn" do
      game.current_player.should == game.players.first
    end

    it "is the second player on the second turn" do
      game.do_move(1)
      game.current_player.should == game.players.last
    end

    it "is the first player on the third turn" do
      game.do_move(1)
      game.do_move(2)
      game.current_player.should == game.players.first
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
