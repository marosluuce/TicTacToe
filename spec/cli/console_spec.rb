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

  it "handles player type selection" do
    fake_io.input << 1 << 1
    @players = [mock(Player), mock(Player)]

    selection = console.select_player_types(@players, Options)
    selection.each do |player, type|
      @players.should include(player)
      Options.player_types.should include(type)
    end
  end

  describe "#request_player" do
    before(:each) do
      @player = mock(Player)
    end

    it "shows the player's options" do
      fake_io.input << 1
      console.should_receive(:show_choices)
      console.request_player(@player, Options)
    end

    it "requests the user's input" do
      clio.should_receive(:request_input).and_return("1\n")
      console.request_player(@player, Options)
    end

    it "stores the player and type when given valid input" do
      fake_io.input << Options.player_types.count + 1 << 1
      console.request_player(@player, Options).should == {@player => Options.player_types[0] }
    end
  end

  it "is false when an invalid choice is made" do
    console.valid_choice?(1, [2, 3]).should eq(false)
  end

  it "is true when valid choice is made" do
    console.valid_choice?(1, [1, 2]).should eq(true)
  end
end
