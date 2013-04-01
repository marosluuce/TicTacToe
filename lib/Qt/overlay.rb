class Overlay < Qt::Label
  def initialize(parent)
    super(parent)
    set_geometry(0, 0, parent.width, parent.height)
    set_style_sheet("font-size: 100px; background: rgba(250, 0, 0, 150)")
    set_alignment(Qt::AlignCenter)
  end
end
