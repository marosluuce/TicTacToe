class CliFormatter
  CURRENT_PLAYER = "%s's Turn!"
  LAST_MOVE = "Last Move: %d"
  WINNER = "%s Won!"
  DRAW = "Draw!"

  def self.board(board)
    string = ""
    board.squares.each_with_index.map do |s, i|
      s.nil? ? i + 1 : s.to_s
    end.each_slice(board.width).with_index do |line, i|
      string << line.join("|")
      string << "\n#{"-" * (board.width * 2 - 1)}\n" unless i == board.length - 1
    end
    string
  end

  def self.current_player(player)
    CURRENT_PLAYER % [player.to_s.upcase]
  end

  def self.last_move(move)
    LAST_MOVE % [move] unless move.nil?
  end

  def self.winner(player)
    player.nil? ? DRAW : WINNER % [player.to_s.upcase]
  end

  def self.player_choices(choices)
    choices.each_with_index.inject("") do |string, (choice, index)|
      string << "#{index+1}. #{choice}\n"
    end
  end
end
