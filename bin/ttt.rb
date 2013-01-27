$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
require "game_builder"

builder = GameBuilder.new(Kernel)
game = builder.build
game.run
