# May need to handle resize event
class Overlay < Qt::Widget
  def initialize(parent)
    super(parent)
    set_geometry(0, 0, parent.width, parent.height)
    set_style_sheet("background: transparent")

    show
  end

  def paintEvent(event)
    painter = Qt::Painter.new(self)
    painter.set_font(Qt::Font.new("Arial", 100))
    painter.draw_text(100, 100, "TEST!!!")
    painter.end
  end
end
