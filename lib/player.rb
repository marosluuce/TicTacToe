require "dumb_strategy"

class Player
  attr_reader :strategy

  def initialize(symbol, strategy=nil)
    @symbol = symbol
    @strategy = strategy
  end

  def get_move
    @strategy.get_move(self)
  end

  def to_s
    @symbol
  end

  def change_strategy(new_strategy)
    @strategy = new_strategy
  end
end
