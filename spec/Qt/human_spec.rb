require "Qt/human"

describe QtHuman do
  it "responds to request_move" do
    human = QtHuman.new
    human.should respond_to(:request_move)
  end
end
