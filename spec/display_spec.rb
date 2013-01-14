require "display"

describe Display do
  describe "#display" do
    it "outputs a string" do
      msg = "Welcome"
      Display.should_receive(:puts).with(msg)
      Display.display msg
    end
  end
end
