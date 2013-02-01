$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
require "Qt4"
require "Qt/main_window"
require "Qt/qt_io"
require "dumb_strategy"
require "input_strategy"
require "player"
require "board"
require "game"

io = QtIO.new
board = Board.tic_tac_toe
dumb_ai = DumbStrategy.new(nil, board, nil)
players = [Player.new(:x, dumb_ai), Player.new(:o, InputStrategy.new(nil, nil, io))]#dumb_ai)]
game = Game.new(players, board, io)
app = Qt::Application.new(ARGV)
#  window = MainWindow.new("Tic-Tac-Toe")
board = BoardWidget.new(io, game)
board.show
#  window.setCentralWidget(board)
app.exec
