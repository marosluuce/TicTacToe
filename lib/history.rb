class History
  def initialize
    @moves = []
  end

  def count
    @moves.count
  end

  def last_move
    @moves.last
  end

  def add_move(move)
    @moves << move
  end

  def remove_last_move
    @moves.pop
  end
end
