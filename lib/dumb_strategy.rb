class DumbStrategy
  def self.get_move(board, calling_player)
    board.available_squares.first
  end
end
