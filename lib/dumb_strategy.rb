class DumbStrategy
  def initialize(board)
    @board = board
  end

  def get_move(calling_player)
    @board.available_squares.first
  end
end
