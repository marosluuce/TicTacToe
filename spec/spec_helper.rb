def fill_board_with_symbol(board, symbol)
  board.size.times do |n|
    board.make_move(n+1, symbol)
  end
end

def set_board_to_draw_state(board)
  board.make_move(1, :x)
  board.make_move(2, :o)
  board.make_move(3, :x)
  board.make_move(4, :x)
  board.make_move(5, :o)
  board.make_move(6, :x)
  board.make_move(7, :o)
  board.make_move(8, :x)
  board.make_move(9, :o)
end

def set_board_to_array(board, squares)
  squares.each_with_index { |s, i| board.make_move(i + 1, s) }
end

def make_moves(game, squares)
  squares.each { |square| game.make_move(square) }
end
