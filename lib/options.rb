require "easy_ai"
require "hard_ai"

class Options
  PLAYERS = {
    "Human" => nil,
    "Easy AI" => EasyAI,
    "Hard AI" => HardAI
  }
  PLAYER_NAMES = ["Human", "Easy AI", "Hard AI"]
  PLAYER_TYPES = [nil, EasyAI, HardAI]

  def self.player_names
    PLAYERS.keys
  end

  def self.player_types
    PLAYERS.values
  end
end
