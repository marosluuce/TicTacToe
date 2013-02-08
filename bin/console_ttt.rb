$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
require "cli/cli_game"

game = CliGame.new($stdin, $stdout)
game.run
