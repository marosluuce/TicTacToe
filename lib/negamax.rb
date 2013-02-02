class Negamax
  def self.to_s
    "Smart AI"
  end

  def initialize(game, io)
    @game = game
  end

  def get_move
    if @game.board.available_squares.include?(5)
      5
    elsif @game.board.available_squares.count == 8
      [1, 3, 7, 9].sample
    else
      run_negamax
    end
  end

  private
  def score_game(symbol)
    if @game.winner.nil?
      0
    elsif @game.winner == symbol
      1
    else
      -1
    end
  end

  # I still don't like this duplication...
  def run_negamax
    best_move = nil
    value = -999
    @game.board.available_squares.each do |square|
      @game.board.set_square(square, @game.current_player)
      score = -negamax()
      @game.board.set_square_nil(square)

      if score > value
        value = score
        best_move = square
      end
    end
    best_move
  end

  def negamax(depth=1)
    return score_game(@game.current_player) if @game.game_over?

    value = -9999
    @game.board.available_squares.each do |square|
      @game.board.set_square(square, @game.current_player)
      value = [value, -negamax(depth+1)].max
      @game.board.set_square_nil(square)
    end
    value /= Float(depth)
  end
end
