class Player
  attr_reader :sym, :input

  def initialize(sym, input)
    @sym = sym
    @input = input
  end

  def get_move
    @input.request_move
  end
end
