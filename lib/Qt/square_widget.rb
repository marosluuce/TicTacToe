require "Qt4"

class SquareWidget < Qt::Label
  signals :clicked

  def initialize(index, game_wrapper)
    super()

    @name = "SquareWidget"
    @index = index
    @game_wrapper = game_wrapper

    set_style_sheet("background-color: #ABD; font-size: 50px")
    set_alignment(Qt::AlignCenter)

    connect(SIGNAL(:clicked)) do
      game_wrapper.make_move(@index)
      update
    end

    @game_wrapper.connect(SIGNAL(:updated)) do
      set_text @game_wrapper.square(@index).to_s
    end
  end

  def mousePressEvent(event)
    emit clicked
  end
end
