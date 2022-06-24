require "./match.rb"
require "./team_rank.rb"

class Day
  attr_reader :team_ranks

  def initialize()
    @team_ranks = []
  end

  def enter_match(team_score_a, team_score_b)
    match = Match.new(team_score_a, team_score_b)
    if match.tie?
      @team_ranks << TeamRank.new(match.winner.team, 1)
      @team_ranks << TeamRank.new(match.loser.team, 1)
    else
      @team_ranks << TeamRank.new(match.winner.team, 3)
      @team_ranks << TeamRank.new(match.loser.team, 0)
    end
  end

  def seen?(team_score)
    !@team_ranks.find { |a| a.team == team_score.team }.nil?
  end

  def teams
    @team_ranks.sort { |a, b| b.team <=> a.team }.sort { |a, b| b.rank <=> a.rank }
  end
end
