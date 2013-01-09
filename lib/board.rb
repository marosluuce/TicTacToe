class Board
	attr_reader :squares
    
    def self.tic_tac_toe
        self.new(3, 3)
    end

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
