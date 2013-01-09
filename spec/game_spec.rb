require "game"
require "board"

describe Game do
    let(:g) { Game.new }

    it "has a tictactoe board" do
        g.board.should be_an_instance_of Board
        g.board.squares.count.should == 9
        # Should probably be checking that
        # Board.tic_tac_toe is called instead
    end
    it "has at least one player" do
        # This also is wrong. Nothing is checking
        # that I am actually making players.:
        g.players.count.should be > 1
    end
end
