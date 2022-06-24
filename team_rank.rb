class TeamRank
  attr_reader :team, :rank

  def initialize(team, rank)
    @team = team
    @rank = rank
  end

  def to_s
    "Team: #{@team} - Rank: #{@rank}"
  end
end
