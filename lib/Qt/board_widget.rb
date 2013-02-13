require "Qt4"
require "Qt/square_widget"

class BoardWidget < Qt::Widget
  def initialize(game_wrapper)
    super()

    grid_layout = Qt::GridLayout.new(self)
    (0...game_wrapper.board_size).each do |index|
      grid_layout.add_widget(SquareWidget.new(index+1, game_wrapper), index / 3, index % 3)
    end
  end
end
