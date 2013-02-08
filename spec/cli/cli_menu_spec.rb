require "cli/cli_menu"
require "cli/cli_formatter"
require "cli/cli_io"
require "board"
require "stringio"

# Might rename this to display or something.
# It might actually output all info.
describe CliMenu do
  let(:fake_io) { StringIO.new }
  let(:clio) { CliIO.new(fake_io, fake_io) }
  let(:menu) { CliMenu.new(clio) }

  it "displays a greeting" do
    menu.greet
    fake_io.string.should include(CliMenu::GREETING)
  end

  it "displays the player choices" do
    choices = {"Human" => nil}
    menu.show_choices(choices)
    fake_io.string.should include("1. Human")
  end

  it "prompts for player choice input" do
    menu.prompt_choices
    fake_io.string.should == CliMenu::CHOICES_PROMPT
  end

  it "displays the board" do
    board = Board.tic_tac_toe
    menu.board(board)
    fake_io.string.should include(CliFormatter::board(board))
  end
end
