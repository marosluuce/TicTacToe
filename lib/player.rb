require "dumb_strategy"

class Player
  attr_reader :strategy

  def initialize(symbol, board, strategy=DumbStrategy)
    @symbol = symbol
    @board = board
    @strategy = strategy
  end

  def get_move
    @strategy.get_move(@board, self)
  end

  def to_s
    @symbol
  end

  def change_strategy(new_strategy)
    @strategy = new_strategy
  end
end
