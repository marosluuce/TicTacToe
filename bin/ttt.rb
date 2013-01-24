$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
require "game_builder"

game = GameBuilder.build
game.run
