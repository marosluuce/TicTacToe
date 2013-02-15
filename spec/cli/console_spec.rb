require "cli/console"
require "cli/console_io"
require "cli/mock_io"
require "board"
require "game"
require "player"
require "easy_ai"
require "options"

describe Console do
  let(:fake_io) { MockIO.new }
  let(:io) { ConsoleIO.new(fake_io, fake_io) }
  let(:options) { Options.new(EasyAI) }
  let(:console) { Console.new(io) }
  let(:game) { Game.tic_tac_toe }

  it "consoles a greeting" do
    console.greet
    fake_io.output.should include("#{Console::GREETING}\n")
  end

  it "consoles the player choices" do
    choices = ["Human", "AI"]
    console.show_choices(choices)
    fake_io.output.should include(Formatter::player_choices(choices))
  end

  it "prompts for player choice input" do
    console.prompt_choices
    fake_io.output.should include(Console::CHOICES_PROMPT)
  end

  it "consoles the board" do
    board = Board.tic_tac_toe
    console.board(board)
    fake_io.output.should include("#{Formatter::board(board)}\n")
  end

  it "consoles a message for invalid input" do
    console.invalid_input
    fake_io.output.should include("#{Console::INVALID_INPUT}\n")
  end

  describe "#draw_game" do
    it "outputs the last move" do
      console.draw_game(game)
      fake_io.output.should include("#{Formatter.last_move(game.last_move)}\n")
    end

    it "outputs the board state" do
      console.draw_game(game)
      fake_io.output.should include("#{Formatter.board(game.board)}\n")
    end

    it "outputs the winner if the game is over" do
      game.stub(:game_over?).and_return(true)
      game.stub(:winner).and_return("x")
      console.draw_game(game)
      fake_io.output.should include("#{Formatter.winner(game.winner)}\n")
    end

    it "outputs the current player if game is not over" do
      console.draw_game(game)
      fake_io.output.should include("#{Formatter.current_player(game.current_player)}\n")
    end
  end

  it "selects a type for a number of players" do
    player_count = 2
    players = console.select_player_types(player_count, options)
    players.count.should == player_count
  end

  describe "#request_player" do
    it "request a choice for player when given valid input" do
      fake_io.input << "aaa" << 2
      choice = console.request_player(options)
      options.player_types.should include(choice)
    end

    it "shows the player's options" do
      fake_io.input << 1
      console.should_receive(:show_choices).exactly(fake_io.input.count)
      console.request_player(options)
    end

    it "requests the user's input" do
      io.should_receive(:request_input).and_return("1\n")
      console.request_player(options)
    end
  end
end
