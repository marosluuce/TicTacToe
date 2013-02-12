require "Qt4"
require "Qt/board_widget"
require "game"

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

    # TODO connect(new_game, ...)
    connect(quit, SIGNAL(:triggered), Qt::Application.instance, SLOT(:quit))

    @game = Game.tic_tac_toe

    set_central_widget(BoardWidget.new(self, @game))

    show
  end
end

