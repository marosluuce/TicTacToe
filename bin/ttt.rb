$: << File.expand_path(File.dirname(__FILE__) + "../lib/")
require_relative '../lib/game'

g = Game.new
g.run
