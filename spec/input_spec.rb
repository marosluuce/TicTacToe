require "input"

describe Input do
  describe "#self.get_console_input" do
    it "calls gets and returns the input" do
      Input.stub(:gets) { "123" }
      Input.get_console_input.should == "123"
    end
    it "should remove \\n from the input" do
      Input.stub(:gets) { "123\n" }
      Input.get_console_input.should == "123"
    end
  end
end
