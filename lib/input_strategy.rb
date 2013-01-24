class InputStrategy
  def initialize(source)
    @source = source
  end

  def get_move(calling_player)
    @source.request_move
  end
end
