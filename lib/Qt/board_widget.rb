require "Qt4"
require "Qt/square_widget"

class BoardWidget < Qt::Widget
  def initialize(game_wrapper)
    super()

    grid_layout = Qt::GridLayout.new(self)
    (0...game_wrapper.board_size).each do |index|
      square = SquareWidget.new(index+1, game_wrapper)

      square.connect(SIGNAL(:clicked)) do
        set_enabled(false)
        game_wrapper.make_move(index+1)
      end

      grid_layout.add_widget(square, index / 3, index % 3)
    end
  end

  def squares
    children.select { |child| child.instance_of? SquareWidget }
  end
end
