require "easy_ai"
require "hard_ai"

class Options
  PLAYERS = {
    "Human" => nil,
    "Easy AI" => EasyAI,
    "Hard AI" => HardAI
  }

  def self.player_names
    PLAYERS.keys
  end

  def self.player_types
    PLAYERS.values
  end

  # This could be named better.
  def self.player_choices
    PLAYERS.map.with_index { |_, i| i }
  end
end
