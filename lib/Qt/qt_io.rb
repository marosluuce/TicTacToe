class QtIO
  attr_accessor :move

  def attach_window(window)
    @window = window
  end

  def gets

  end

  def request_move
    move = @window.get_move
    puts move
    move
  end

  def puts(msg)
    @window.set_message(msg)
  end

  def print

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
