class Game
  attr_reader :board, :players

  def initialize(players, board, io)
    @board = board
    @players = players
    @io = io
  end

  def do_move(i, sym)
    @board.set_square(i.to_i, sym)
  end

  # Game shouldn't be handling this anymore. Probably get rid of everything
  # except do_move.
  def move
    begin
      move = get_move
    end while not validate_move(move)
    do_move(move, current_player)
  end

  def get_move
    current_player.get_move
  end

  def validate_move(move)
    @board.available_squares.include? move.to_i
  end

  # This needs to die for the sake of control. Game runner controls all!
  def run
    draw
    until game_over?
      turn
    end
  end

  def turn
    move
    draw
  end

  def draw?
    @board.full? && winner.nil?
  end

  def game_over?
    @board.full? || !winner.nil?
  end

  def winner
    possible_wins = []
    (0...@board.width).each do |n|
      possible_wins << @board.squares.select.with_index do  |s, i|
        i / @board.width == n
      end.uniq
      possible_wins << @board.squares.select.with_index do |s, i|
        i % @board.width == n
      end.uniq
      possible_wins << @board.squares.select.with_index do |s, i|
        i / @board.width == i % @board.width
      end.uniq
      possible_wins << @board.squares.select.with_index do |s, i|
        i % (@board.width - 1) == 0 && i != 0 && i != (@board.squares.count - 1)
      end.uniq
    end

    winning_player = nil
    possible_wins.each do |possible|
      if possible.count == 1 && !possible.first.nil?
        winning_player = possible.first
        break
      end
    end

    winning_player
  end

  def current_player
    @board.squares.compact.count.even? ? @players.first : @players.last
  end

  # DIE FUNCTION!
  def draw
    @io.print_last_move(@board.last_move)
    if game_over?
      @io.print_winner(winner)
    else
      @io.print_turn(@players.first)
    end
    @io.puts "#{@board}"
  end
end
