class Player
  attr_reader :sym

  def initialize(sym)
    @sym = sym
  end

  def get_input
    gets.chomp
  end
end
