require "cli/cli_menu"
require "cli/cli_formatter"
require "cli/cli_io"
require "cli/mock_io"
require "board"
require "player"
require "options"

# Might rename this to display or something.
# It might actually output all info.
describe CliMenu do
  let(:fake_io) { MockIO.new }
  let(:clio) { CliIO.new(fake_io, fake_io) }
  let(:menu) { CliMenu.new(clio) }

  it "displays a greeting" do
    menu.greet
    fake_io.output.should include("#{CliMenu::GREETING}\n")
  end

  it "displays the player choices" do
    choices = ["Human", "AI"]
    menu.show_choices(choices)
    fake_io.output.should include(CliFormatter::player_choices(choices))
  end

  it "prompts for player choice input" do
    menu.prompt_choices
    fake_io.output.should include(CliMenu::CHOICES_PROMPT)
  end

  it "displays the board" do
    board = Board.tic_tac_toe
    menu.board(board)
    fake_io.output.should include("#{CliFormatter::board(board)}\n")
  end

  it "draws the game state"

  describe "#request_players" do
    before(:each) do
      @players = [mock(Player), mock(Player)]
    end

    it "requests the user's input" do
      clio.should_receive(:request_input).twice.and_return("1\n")
      menu.request_players(@players, Options)
    end

    it "stores the user's valid choice" do
      fake_io.input << Options.player_types.count + 1 << 1 << 2
      choices = menu.request_players(@players, Options)
      choices.keys.should == @players
      choices.each do |_, type|
        Options.player_types.should include(type)
      end
    end
  end
end
