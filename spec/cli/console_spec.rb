require "cli/console"
require "cli/console_io"
require "cli/mock_io"
require "board"
require "player"
require "options"

# Might rename this to display or something.
# It might actually output all info.
describe Console do
  let(:fake_io) { MockIO.new }
  let(:clio) { ConsoleIO.new(fake_io, fake_io) }
  let(:console) { Console.new(clio) }

  it "displays a greeting" do
    console.greet
    fake_io.output.should include("#{Console::GREETING}\n")
  end

  it "displays the player choices" do
    choices = ["Human", "AI"]
    console.show_choices(choices)
    fake_io.output.should include(Formatter::player_choices(choices))
  end

  it "prompts for player choice input" do
    console.prompt_choices
    fake_io.output.should include(Console::CHOICES_PROMPT)
  end

  it "displays the board" do
    board = Board.tic_tac_toe
    console.board(board)
    fake_io.output.should include("#{Formatter::board(board)}\n")
  end

  it "displays a message for invalid input" do
    console.invalid_input
    fake_io.output.should include("#{Console::INVALID_INPUT}\n")
  end

  it "draws the game state"

  describe "#request_players" do
    before(:each) do
      @players = [mock(Player), mock(Player)]
    end

    it "requests the user's input" do
      clio.should_receive(:request_input).twice.and_return("1\n")
      console.request_players(@players, Options)
    end

    it "stores the user's valid choice" do
      fake_io.input << Options.player_types.count + 1 << 1 << 2
      choices = console.request_players(@players, Options)
      choices.keys.should == @players
      choices.each do |_, type|
        Options.player_types.should include(type)
      end
    end
  end
end
