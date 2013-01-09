require "board"

class Game
    attr_reader :board, :players

    def initialize
        @board = Board.tic_tac_toe
    end
end
