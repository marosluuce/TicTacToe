require "player"
require "board"
require "negamax"

describe "Never Loses" do
  it "never loses" do
    board = Board.tic_tac_toe
    player = Player.new(:o, board, nil)
    negamax = Negamax.new(:x, player)
    player.change_strategy(negamax)
    never_loses(player, board).should be_true
  end
end

def never_loses(ai, board, index=0)
  return (board.winner == ai || board.draw?) if board.game_over?

  ai_never_loses = true
  if index.odd?
    move = ai.get_move
    board.set_square(move, ai)
    ai_never_loses &&= never_loses(ai, board, index+1)
    board.set_square_nil(move)
  else
    board.available_squares.each do |square|
      board.set_square(square, :x)
      ai_never_loses &&= never_loses(ai, board, index+1)
      board.set_square_nil(square)
    end
  end
  ai_never_loses
end
