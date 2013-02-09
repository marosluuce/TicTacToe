class MockIO
  attr_accessor :input, :output

  def initialize
    clear
  end

  def clear
    @input = []
    @output = []
  end

  def puts(msg)
    @output << "#{msg}\n"
  end

  def gets
    @input.shift
  end

  def print(msg)
    @output << msg
  end
end
