#require "game_builder"
#
## This class will probably turn into the console game runner menu
#class MainMenu
#  WELCOME_MESSAGE = "Welcome to Tic-Tac-Toe!"
#  USER_PROMPT = "Enter your choice: "
#
#  attr_reader :players
#
#  def initialize(io)
#    @io = io
#  end
#
#  def request_choice
#    #@io.puts USER_PROMPT
#    choice = nil
#    until GameBuilder::STRATEGIES.keys.include?(choice)
#      choice = @io.gets.to_i
#    end
#    choice
#  end
#
#  def display_choices
#    choices = GameBuilder::STRATEGIES.map do |key, value|
#      "#{key}. #{value.to_s}"
#    end.join("\n")
#    @io.puts choices
#  end
#
#  def display_welcome
#    @io.puts WELCOME_MESSAGE
#  end
#
#  def request_player_choice
#    display_choices
#    request_choice
#  end
#end
