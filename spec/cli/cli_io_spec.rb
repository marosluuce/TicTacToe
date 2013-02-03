require "cli/cli_io"
require "stringio"

describe CliIO do
  let(:fake_io) { StringIO.new }
  let(:clio) { CliIO.new(fake_io, fake_io) }

  it "outputs a message" do
    clio.puts "message"
    fake_io.string == "message"
  end

  it "gets input" do
    fake_io.string = "1\n"
    clio.gets.should include("1")
  end

  it "prompts with a message" do
    clio.prompt "Enter choice"
    fake_io.string.should_not include("\n")
  end
end
