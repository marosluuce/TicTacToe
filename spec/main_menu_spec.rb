require "main_menu"
require "player"
require "input_strategy"
require "game"
require "stringio"

describe MainMenu do
  let(:fake_input) { StringIO.new("1\n") }
  let(:strategies) { {1 => InputStrategy} }
  let(:menu) { MainMenu.new(fake_input, strategies) }

  # TODO: Implement a wrapper object responsible for IO that can be faked with StringIO.
  it "gets the user's input" do
    menu.request_choice.should be_an_instance_of Fixnum
    #fake_input.string.should include(MainMenu::USER_PROMPT)
  end

  it "does not allow invalid input" do
    fake_input.string = "a\n1\n"
    menu.request_choice.should == 1
  end

  it "displays the choices for the user" do
    menu.display_choices
    fake_input.string.should include("1")
  end

  it "displays a welcome message" do
    menu.display_welcome
    fake_input.string.should include(MainMenu::WELCOME_MESSAGE)
  end

  it "gets a choice for a player" do
    menu.should_receive(:display_choices)
    menu.should_receive(:request_choice)
    menu.request_player_choice
  end
end
