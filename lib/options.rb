require "easy_ai"
require "hard_ai"

class Options
  PLAYERS = {
    "Easy AI" => EasyAI,
    "Hard AI" => HardAI
  }

  def initialize(human)
    @players = PLAYERS
    @players["Human"] = human
  end

  def player_names
    @players.keys
  end

  def player_types
    @players.values
  end

  def players_from_choices(choices)
    choices.map { |choice| player_types[choice] }
  end
end
