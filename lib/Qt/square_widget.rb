require "Qt4"

class SquareWidget < Qt::Label
  signals "clicked(int)"

  def initialize(index, game_wrapper)
    super()

    @name = "SquareWidget"
    @index = index
    @game_wrapper = game_wrapper

    set_style_sheet("background-color: #ABD; font-size: 50px")
    set_alignment(Qt::AlignCenter)
  end

  def mousePressEvent(event)
    emit clicked(@index)
  end

  def paintEvent(event)
    set_text @game_wrapper.square(@index)
    super(event)
  end
end
