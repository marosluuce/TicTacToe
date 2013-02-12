require "Qt4"
require "Qt/square_widget"

class BoardWidget < Qt::Widget
  def initialize(parent, game)
    super(parent)

    @grid_layout = Qt::GridLayout.new(self)
    (0...game.board.size).each do |index|
      @grid_layout.add_widget(SquareWidget.new(parent, index+1, game), index / 3, index % 3)
    end
  end
end
