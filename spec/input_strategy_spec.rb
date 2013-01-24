require "input_strategy"

describe InputStrategy do
  it "gets the input" do
    fake_input = "fake_input"
    fake_input.should_receive(:request_move)
    input = InputStrategy.new(fake_input)
    input.get_move(nil)
  end
end
