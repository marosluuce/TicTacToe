require "display"

describe Display do
  describe "#display" do
    it "outputs a string" do
      msg = "Welcome"
      Display.should_receive(:puts).with("\n" + msg)
      Display.display msg
    end
  end

  describe "#print_turn" do
    it "prints whose turn it is" do
      sym = :x
      Display.should_receive(:display).with("x's turn!")
      Display.print_turn(sym)
    end
  end

  describe "#print_winner" do
    it "outputs draw if there is no winner" do
      Display.should_receive(:display).with("Draw!")
      Display.print_winner(nil)
    end
    it "outputs the winner" do
      Display.should_receive(:display).with("x Won!")
      Display.print_winner(:x)
    end
  end

  describe "#print_last_move" do
    it "does nothing if last move is nil" do
      Display.should_not_receive(:display)
      Display.print_last_move(nil)
    end
    it "prints the last move" do
      Display.should_receive(:display).with("Last move: 1")
      Display.print_last_move(1)
    end
  end
end
