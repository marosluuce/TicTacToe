class Display
  def self.request_move
    print "\nEnter your move: "
    gets
  end

  def self.display(msg)
    puts "\n" + msg.to_s
  end

  def self.print_turn(player)
    turn_info = "#{player.to_s}'s turn!"
    display(turn_info)
  end

  def self.print_winner(winner)
    output = ""
    if winner.nil?
      output = "Draw!"
    else
      output = "#{winner.to_s} Won!"
    end
    display(output)
  end

  def self.print_last_move(move)
    display("Last move: #{move}") if !move.nil?
  end
end
