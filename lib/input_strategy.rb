class InputStrategy
  def initialize(source)
    @source = source
  end

  def get_move(board, calling_player)
    @source.request_move
  end
end
