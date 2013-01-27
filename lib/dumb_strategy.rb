class DumbStrategy
  def self.to_s
    "Dumb AI"
  end

  def initialize(players, board, io)
    @board = board
  end

  def get_move(calling_player)
    @board.available_squares.first
  end
end
