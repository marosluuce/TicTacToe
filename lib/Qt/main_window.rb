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
  signals "set_move(int)"
  attr_accessor :move

  def initialize(io, game)
    super()
    @io = io.attach_window(self)
    @game = game
    @grid_layout = Qt::GridLayout.new(self)
    (0...9).each do |n|
      square = BoardSquare.new(n + 1)
      @grid_layout.add_widget(square, n / 3, n % 3)
      connect(square, SIGNAL(:clicked)) { set_move(square.index) }
    end
    @text = Qt::TextEdit.new(self)
    @text.resize(300, 400)
    @timer = Qt::Timer.new(self)

    connect(@timer, SIGNAL(:timeout)) { @game.turn }
    @timer.start(3000)
  end

  def set_message(msg)
    @text.text = @text.to_plain_text + msg.to_s
    @move = nil
  end

  def set_move(move)
    @move = move
  end

  def get_move
#    while @move.nil?
#      Qt::CoreApplication::process_events
#    end
#    loop = Qt::EventLoop
#    connect(SIGNAL("set_move(int)")) { loop.exit(0) }
#    loop.send(:exec)
    @move
  end

  def mouse_released(event)
  end
end

class BoardSquare < Qt::PushButton
  attr_reader :index

  def initialize(index)
    super()
    @index = index
    @symbol = "X"
  end

  def switch_symbol
    @symbol = case @symbol
              when ""
                "X"
              when "X"
                "O"
              else
                ""
              end
  end

  def paintEvent(event)
    painter = Qt::Painter.new(self)
    painter.set_pen(Qt::blue)
    painter.set_font(Qt::Font.new("Arial", 30))
    painter.draw_text(rect(), Qt::AlignCenter, @symbol)
    painter.end
  end
end
