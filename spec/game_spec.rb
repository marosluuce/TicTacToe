require "game"
require "board"

describe Game do
    let(:g) { Game.new }

    it "has a board" do
        g.should respond_to :board    
        g.board.should be_an_instance_of Board
    end
end
