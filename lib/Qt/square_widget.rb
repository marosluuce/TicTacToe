require "Qt4"

class SquareWidget < Qt::Label
  signals :clicked

  def initialize(index, game_wrapper)
    super()

    @name = "SquareWidget"
    @index = index

    set_style_sheet("background-color: #ABD; font-size: 50px")
    set_alignment(Qt::AlignCenter)

    # Not sure if I like this because it still sends input to
    # the game.
    connect(SIGNAL(:clicked)) do
      begin
        game_wrapper.make_move(@index)
        set_text game_wrapper.square(@index).to_s
        update
      rescue InvalidMoveException
      end
    end
  end

  def mousePressEvent(event)
    emit clicked
  end
end
