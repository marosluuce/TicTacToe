class CliFormatter
  def self.format_board(board)
    string = ""
    board.squares.each_with_index.map do |s, i|
      s.nil? ? i + 1 : s.to_s
    end.each_slice(board.width).with_index do |line, i|
      string << line.join("|")
      string << "\n#{"-" * (board.width * 2 - 1)}\n" unless i == board.length - 1
    end
    string
  end
end
