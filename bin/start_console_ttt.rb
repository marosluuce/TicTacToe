#!/usr/bin/env ruby

$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib/"))
require "cli/tic_tac_toe"

game = TicTacToe.new($stdin, $stdout)
game.prepare_game
game.run
