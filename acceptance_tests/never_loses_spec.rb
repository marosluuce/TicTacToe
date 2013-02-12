require "player"
require "board"
require "hard_ai"
require "game"

describe "AI Never Loses" do
  it "never loses with negamax strategy" do
    game = Game.tic_tac_toe
    board = Board.tic_tac_toe
    never_loses(HardAI, game).should eq(true)
  end
end

def never_loses(ai, game, index=0)
  return (game.winner == game.players.last || game.draw?) if game.game_over?

  ai_never_loses = true
  if index.even?
    game.board.available_moves.each do |square|
      game.make_move(square)
      ai_never_loses &&= never_loses(ai, game, index+1)
      game.undo_last_move
    end
  else
    move = ai.get_move(game)
    game.make_move(move)
    ai_never_loses &&= never_loses(ai, game, index+1)
    game.undo_last_move
  end
  ai_never_loses
end
