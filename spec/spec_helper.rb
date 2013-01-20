def fill_board_with_symbol(board, symbol)
  board.squares.each_index do |i|
    board.set_square(i, symbol)
  end
end

def set_board_to_draw_state(board)
  board.set_square(1, :x)
  board.set_square(2, :o)
  board.set_square(3, :x)
  board.set_square(4, :x)
  board.set_square(5, :o)
  board.set_square(6, :x)
  board.set_square(7, :o)
  board.set_square(8, :x)
  board.set_square(9, :o)
end

def set_board_to_array(board, squares)
  squares.each_with_index { |s, i| board.set_square(i + 1, s) }
end
