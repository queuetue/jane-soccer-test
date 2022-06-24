class TeamScore
  attr_reader :team, :score

  def initialize(team, score)
    @team = team
    @score = score
  end

  def to_s
    "Team: #{@team} - Score: #{@score}"
  end
end
