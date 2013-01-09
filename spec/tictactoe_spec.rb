require "tictactoe"

#describe "xy_to_i" do
#	it "converts (0, 0, 0) to 0" do
#		index = xy_to_i(0, 0, 0)
#		index.should == 0	
#	end
#	it "converts (1, 1, 2) to " do
#	end
#end

describe Board do
  let(:length) { 3 }
	let(:width) { 3 }
  let(:b) { Board.new(length, width) }
	
	it "creates a board with two arguments" do
		b.should be_an_instance_of Board
	end
	it "has squares which is an array" do
		b.squares.should be_an_instance_of Array
	end
	it "has squares with length equal to length * width" do
		b.squares.count.should == length * width
	end

	describe "#set_square" do
		it "sets the square to value" do
			b.set_square(0, :x)
			b.squares[0].should == :x
		end
		it "only sets the value if the square is empty" do
			b.set_square(0, :x)
			b.set_square(0, :o)
			b.squares[0].should == :x
		end
	end

	describe "#get_square" do
		it "gets the value of a square" do
			b.set_square(0, :x)
			b.get_square(0).should == :x
		end
	end
end
