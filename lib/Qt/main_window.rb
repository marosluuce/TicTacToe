require "Qt4"
require "Qt/board_widget"
require "Qt/new_game_dialog"
require "Qt/human"
require "Qt/game_wrapper"
require "Qt/experiments"

class MainWindow < Qt::MainWindow
  def initialize(title=nil, size=[640, 480])
    super()

    self.window_title = title
    resize(*size)

    @human = QtHuman.new
    @options = Options.new(@human)
    @game_wrapper = GameWrapper.new
    @board = BoardWidget.new(@game_wrapper)
    @overlay = Overlay.new(@board)

    create_actions
    setup_menus
    setup_connections

    show
    prompt_new_game_dialog
  end

  def create_actions
    @new_game = Qt::Action.new(tr("&New Game"), self)
    @new_game.shortcut = Qt::KeySequence.new(Qt::Key_N|Qt::CTRL)
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
    @new_game.connect(SIGNAL(:triggered)) { prompt_new_game_dialog }
    @quit.connect(SIGNAL(:triggered)) { Qt::Application.instance.quit }
    @game_wrapper.connect(SIGNAL("game_over(QString)")) do |message|
      @overlay.set_text(message)
      @overlay.show
    end
    @human.connect(SIGNAL(:unlock)) { @board.set_enabled(true) }
  end

  def prompt_new_game_dialog
    new_game_dialog = NewGameDialog.new(@options.player_names)
    new_game_dialog.setup_ui

    new_game_dialog.connect(SIGNAL(:accepted)) do
      choices = new_game_dialog.player_choices
      create_new_game(choices)
    end
    new_game_dialog.exec
  end

  def create_new_game(choices)
    players = @options.players_from_choices(choices)
    @game_wrapper.new_game(players)
    @overlay.hide
    set_central_widget(@board)
    @board.set_enabled(false)
    @game_wrapper.take_turn
  end

  def resizeEvent(event)
    @overlay.resize(event.size)
    event.accept
  end
end
