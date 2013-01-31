require "uiwrapper"
require "stringio"

describe UIWrapper do
  let (:source) { StringIO.new }
  let (:uiwrapper) { UIWrapper.new(source) }

  it "gets input" do
    source.string = "123\n"
    input = uiwrapper.gets
    input.should == "123\n"
  end
  it "puts a string" do
    msg = "Welcome"
    uiwrapper.puts msg
    source.string.should include(msg)
  end

  it "prints a string" do
    msg = "Welcome"
    uiwrapper.print msg
    source.string.should include(msg)
  end

  it "prints whose turn it is" do
    sym = :x
    uiwrapper.print_turn(sym)
    source.string.should include("x's turn!")
  end

  it "outputs draw if there is no winner" do
    uiwrapper.print_winner(nil)
    source.string.should include("Draw!")
  end
  it "outputs the winner" do
    uiwrapper.print_winner(:x)
    source.string.should include("x Won!")
  end

  it "does nothing if last move is nil" do
    uiwrapper.print_last_move(nil)
    source.string.should == ""
  end

  it "prints the last move" do
    uiwrapper.print_last_move(1)
    source.string.should include("Last move: 1")
  end
end
