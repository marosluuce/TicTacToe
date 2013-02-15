require "cli/human"
require "cli/console"
require "cli/console_io"
require "cli/mock_io"
require "game_runner"

describe Human do
  let(:fake_io) { MockIO.new }
  let(:io) { ConsoleIO.new(fake_io, fake_io) }
  let(:console) { Console.new(io) }
  let(:human) { Human.new(console) }

  it "gets a move and gives it to the game runner" do
    fake_io.input << "1"
    runner = mock(GameRunner, :make_move => nil)
    runner.should_receive(:make_move).with(1)
    human.request_move(runner)
  end

  it "gets a move from the console" do
    fake_io.input << "1"
    human.get_move.should == 1
  end
end
