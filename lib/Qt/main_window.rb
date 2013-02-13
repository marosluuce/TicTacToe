require "Qt4"
require "Qt/board_widget"
require "Qt/new_game_dialog"
require "Qt/game_widget"
require "Qt/experiments"
require "options"

class MainWindow < Qt::MainWindow
  def initialize(title=nil, size=[640, 480])
    super()

    self.window_title = title
    resize(*size)

    create_actions
    setup_menus
    setup_connections

    show
  end

  def create_actions
    @new_game = Qt::Action.new(tr("&New Game"), self)
    @new_game.shortcut = Qt::KeySequence.new(Qt::Key_N  | Qt::CTRL)
    @quit = Qt::Action.new(tr("&Quit"), self)
  end

  def setup_menus
    file = self.menu_bar.addMenu(tr("&File"))
    file.add_action(@new_game)
    file.add_action(@quit)

    self.status_bar
    self.status_bar.set_size_grip_enabled(false)
  end

  def setup_connections
    @new_game.connect(SIGNAL(:triggered)) do
      new_game_dialog = NewGameDialog.new(Options.player_names)
      new_game_dialog.setup_ui

      new_game_dialog.connect(SIGNAL(:accepted)) { create_new_game }
      new_game_dialog.exec
    end
    @quit.connect(SIGNAL(:triggered)) { Qt::Application.instance.quit }
  end

  def create_new_game
    @game_wrapper = GameWrapper.new
    @game_wrapper.connect(SIGNAL(:game_over)) { game_over }
    @board = BoardWidget.new(@game_wrapper)
    set_central_widget(@board)
  end

  def game_over
    Overlay.new(@board)
  end
end

class TurnWidget < Qt::Label

end
