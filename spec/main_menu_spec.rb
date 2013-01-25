require "main_menu"
require "player"
require "input_strategy"
require "game"
require "stringio"

describe MainMenu do
  let(:fake_input) { StringIO.new("1\n") }
  let(:menu) { MainMenu.new(fake_input) }

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
    fake_input.string.should include(MainMenu::PLAYER_CHOICES)
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

  it "creates a strategy for a player" do
    player = Player.new(:x)
    menu.give_player_strategy(player, 1)
    player.strategy.should be_an_instance_of InputStrategy
  end

  # TODO - FIX this test. This is badddddddd.
  it "sets a strategy each player" do
    fake_input.string = "1\n" * 35
    menu.configure_players
    menu.players.each { |player| player.strategy.should_not be_nil }
  end

  it "welcomes, configures players, and builds the game" do
    menu.should_receive(:display_welcome)
    menu.should_receive(:configure_players)
    menu.run.should be_an_instance_of Game
  end
end
