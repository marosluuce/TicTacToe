require "input"

describe Input do
  describe "#self.request_move" do
    it "calls gets and returns the input" do
      Input.stub(:gets) { "123" }
      Input.request_move.should == "123"
    end
  end
end
