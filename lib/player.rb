class Player
  def initialize(symbol, strategy=nil)
    @symbol = symbol
    @strategy = strategy
  end

  def get_move
    @strategy.get_move unless @strategy.nil?
  end

  def to_s
    @symbol
  end
end
