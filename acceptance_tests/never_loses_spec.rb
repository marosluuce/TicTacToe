require "player"
require "board"
require "negamax"

describe "AI Never Loses" do
  it "never loses with negamax strategy" do
    board = Board.tic_tac_toe
    ai = Player.new(:o)
    negamax = Negamax.new([:x, ai], board, nil)
    ai.change_strategy(negamax)
    never_loses(ai, board).should be_true
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
