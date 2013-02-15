require "easy_ai"
require "game_runner"
require "board"
require "game"

describe EasyAI do
  before(:each) do
    @board = Board.tic_tac_toe
    Board.stub(:new).and_return(@board)
    @game = Game.tic_tac_toe
  end

  it "is the first available move" do
    EasyAI.get_move(@game).should == @board.available_moves.first
  end

  it "gets a move and gives it to the game runner" do
    runner = mock(GameRunner, :make_move => nil, :game => @game)
    runner.should_receive(:make_move).with(@board.available_moves.first)
    EasyAI.request_move(runner)
  end
end
