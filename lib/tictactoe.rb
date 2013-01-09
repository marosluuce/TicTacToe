#def xy_to_i(x, y, width)
#	0
#end

class Board
	attr_reader :squares
	
	def initialize(length, width)
		@squares = Array.new(length * width) 
	end

	def set_square(i, val)
		@squares[i] = val if @squares[i] == nil	
	end

	def get_square(i)
		@squares[i]
	end
end
