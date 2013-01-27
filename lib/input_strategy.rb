class InputStrategy
  def self.to_s
    "Human"
  end

  def initialize(players, board, io)
    @io = io
  end

  def get_move(calling_player)
    @io.request_move
  end
end
