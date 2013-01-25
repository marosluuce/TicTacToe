$: << File.expand_path(File.dirname(__FILE__) + "/../lib/")
require "main_menu"

menu = MainMenu.new(Kernel)
game = menu.run
game.run
