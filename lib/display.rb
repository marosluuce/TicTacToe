class Display
  def self.display(msg)
    puts "\n" + msg.to_s
  end

  def self.print_turn(sym)
    turn_info = "#{sym.upcase}'s turn!"
    display(turn_info)
  end

  def self.print_winner(sym)
    output = ""
    if sym.nil?
      output = "Draw!"
    else
      output = "#{sym.upcase} Won!"
    end
    display(output)
  end

  def self.print_last_move(move)
    display("Last move: #{move}") if !move.nil?
  end
end
