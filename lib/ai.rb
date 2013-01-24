class AI
  attr_reader :strategy

  def initialize(sym, board, strategy)
    @sym = sym
    @board = board
    @strategy = strategy
  end

  def get_move
    @strategy.get_move(@board, self)
  end

  def to_s
    @sym
  end

  def change_strategy(new_strategy)
    @strategy = new_strategy
  end
end
