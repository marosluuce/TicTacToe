require "cli/console_io"
require "cli/mock_io"

describe ConsoleIO do
  let(:fake_io) { MockIO.new }
  let(:io) { ConsoleIO.new(fake_io, fake_io) }

  it "outputs a message" do
    io.puts "message"
    fake_io.output.should include("message\n")
  end

  it "gets input" do
    fake_io.input << "1"
    io.gets.should == "1"
  end

  it "prompts with a message" do
    io.prompt "Enter choice"
    fake_io.output.should include("Enter choice")
  end

  it "prompts and gets input" do
    fake_io.input << "1"
    io.request_input("Enter choice").should == "1"
    fake_io.output.should include("Enter choice")
  end
end
