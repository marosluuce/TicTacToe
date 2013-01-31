class UIWrapper
  def initialize(source)
    @source = source
  end

  def gets
    @source.gets
  end

  def request_move
    print "\nEnter your move: "
    gets
  end

  def puts(msg)
    @source.puts "\n" + msg.to_s
  end

  def print(msg)
    @source.print msg
  end

  def print_turn(player)
    turn_info = "#{player.to_s}'s turn!"
    puts turn_info
  end

  def print_winner(winner)
    output = ""
    if winner.nil?
      output = "Draw!"
    else
      output = "#{winner.to_s} Won!"
    end
    puts output
  end

  def print_last_move(move)
    puts "Last move: #{move}" if !move.nil?
  end
end
