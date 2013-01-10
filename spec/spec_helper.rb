def fill_board_with_symbol(board, symbol)
  board.squares.each_index do |i|
    board.set_square(i, symbol)
  end
end
