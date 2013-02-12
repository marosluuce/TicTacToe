#!/usr/bin/env ruby

$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib/"))

require "Qt/main_window"

app = Qt::Application.new(ARGV)
main_window = MainWindow.new("Tic-Tac-Toe")
app.exec
