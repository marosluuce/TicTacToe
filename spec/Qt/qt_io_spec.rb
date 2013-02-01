require "Qt/qt_io"

describe QtIO do
  let(:io) { QtIO.new }

  it "receives a message and outputs the result" do
    io.print_message()
  end
end
