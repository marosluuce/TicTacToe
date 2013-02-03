class CliIO
  def initialize(input, output)
    @input = input
    @output = output
  end

  def puts(msg)
    @output.puts msg
  end

  def gets
    @input.gets
  end

  def prompt(msg)
    @output.print msg
  end
end
