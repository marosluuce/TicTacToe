require "Qt4"

class MainWindow < Qt::MainWindow
  def initialize(title=nil, size=[640, 480])
    super()

    self.window_title = title
    self.resize(*size)

    new_game = Qt::Action.new(tr("&New Game"), self)
    quit = Qt::Action.new(tr("&Quit"), self)

    file = self.menu_bar.addMenu(tr("&File"))
    file.add_action(new_game)
    file.add_action(quit)

    connect(quit, SIGNAL(:triggered), Qt::Application.instance, SLOT(:quit))
    show
  end
end

class BoardWidget < Qt::Widget
  def initialize
    super
    @grid_layout = Qt::GridLayout.new(self)
    (0...9).each do |n|
      @grid_layout.add_widget(BoardSquare.new, n / 3, n % 3)
    end
  end
end

class BoardSquare < Qt::Widget
  def initialize
    super
    @symbol = "X"
  end

  def mouseReleaseEvent(event)
    switch_symbol
    update
  end

  def switch_symbol
    @symbol = @symbol == "X" ? "O" : "X"
  end

  def paintEvent(event)
    painter = Qt::Painter.new(self)
    painter.set_pen(Qt::blue)
    painter.set_font(Qt::Font.new("Arial", 30))
    painter.draw_text(rect(), Qt::AlignCenter, @symbol)
    painter.end
  end
end

if $0 == __FILE__
  app = Qt::Application.new(ARGV)
  window = MainWindow.new("Tic-Tac-Toe")
  board = BoardWidget.new
  board.show
  window.setCentralWidget(board)
  app.exec
end
