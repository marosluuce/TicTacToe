require "player"
require "board"
require "negamax"
require "game"

describe "AI Never Loses" do
  it "never loses with negamax strategy" do
    game = Game.new
    board = Board.tic_tac_toe
    ai = Player.new(:o, Negamax.new(game))
    game.load_config({:board => board, :players => [:x, ai]})
    never_loses(ai, game).should be_true
  end
end

def never_loses(ai, game, index=0)
  return (game.winner == ai || game.draw?) if game.game_over?

  ai_never_loses = true
  if index.even?
    game.board.available_squares.each do |square|
      game.do_move(square)
      ai_never_loses &&= never_loses(ai, game, index+1)
      game.undo_last_move
    end
  else
    move = ai.get_move
    game.do_move(move)
    ai_never_loses &&= never_loses(ai, game, index+1)
    game.undo_last_move
  end
  ai_never_loses
end
