require "Qt/game_wrapper"
require "spec_helper"

describe GameWrapper do
  let(:wrapper) { GameWrapper.new }

  before(:each) do
    @game = Game.tic_tac_toe
    @game.stub(:game_over?).and_return(true)
    Game.stub(:new).and_return(@game)
  end

  it "is a draw message if the game is a draw" do
    @game.stub(:draw?).and_return(true)
    wrapper.end_game_message.should == "Draw!"
  end

  it "is the winner if the game has a winner" do
    @game.stub(:winner).and_return("x")
    wrapper.end_game_message.should == "X Won!"
  end
end
