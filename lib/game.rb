require "board"

class Game
    attr_reader :board

    def initialize
        @board = Board.tic_tac_toe
    end
end
