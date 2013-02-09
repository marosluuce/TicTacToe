require "cli/cli_io"
require "cli/mock_io"

describe CliIO do
  let(:fake_io) { MockIO.new }
  let(:clio) { CliIO.new(fake_io, fake_io) }

  it "outputs a message" do
    clio.puts "message"
    fake_io.output.should include("message\n")
  end

  it "gets input" do
    fake_io.input << "1"
    clio.gets.should == "1"
  end

  it "prompts with a message" do
    clio.prompt "Enter choice"
    fake_io.output.should include("Enter choice")
  end

  it "prompts and gets input" do
    fake_io.input << "1"
    clio.request_input("Enter choice").should == "1"
    fake_io.output.should include("Enter choice")
  end
end
