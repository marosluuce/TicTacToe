require "history"
require "board"
require "rules"
require "player"

class InvalidMoveException < Exception
end

class Game
  attr_reader :board, :move_history, :players

  def self.tic_tac_toe
    board = Board.tic_tac_toe
    rules = Rules.new(board)
    players = [Player.new(:x), Player.new(:o)]
    Game.new(board, rules, players)
  end

  def initialize(board, rules, players)
    @board = board
    @rules = rules
    @players = players
    @move_history = History.new
  end

  def make_move(move)
    if valid_move?(move)
      @board.make_move(move, current_player)
      @move_history.add_move(move)
    else
      raise InvalidMoveException
    end
  end

  def valid_move?(move)
    @board.available_moves.include? move
  end

  def last_move
    @move_history.last_move
  end

  def undo_last_move
    move = @move_history.remove_last_move
    @board.undo_move(move)
  end

  def game_over?
    @rules.game_over?
  end

  def current_player
    @players[@move_history.count % @players.count]
  end

  def winner
    @rules.winner
  end
end
