class Human
  def initialize(console)
    @console = console
  end

  def request_move(runner)
    move = get_move
    runner.make_move(move)
  end

  def get_move
    @console.prompt_move.to_i
  end
end
