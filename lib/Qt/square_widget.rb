require "Qt4"

class SquareWidget < Qt::Label
  signals :clicked

  def initialize(parent, index, game)
    super(parent)

    @name = "SquareWidget"
    @index = index
    @value = nil

    set_style_sheet("background-color: #ABD; font-size: 50px")
    set_alignment(Qt::AlignCenter)

    connect(SIGNAL(:clicked)) do
      game.make_move(@index)
      set_text game.board.square(@index).to_s
      update
    end
  end

  def mouseReleaseEvent(event)
    emit clicked
  end
end
