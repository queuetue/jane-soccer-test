class Match
  attr_accessor :winner, :loser

  def initialize(team_score_a, team_score_b)
    @team_score_a = team_score_a
    @team_score_b = team_score_b
    self.calc_winner
  end

  def tie?
    @team_score_a.score == @team_score_b.score
  end

  def calc_winner
    if @team_score_a.score > @team_score_b.score
      @winner = @team_score_a
      @loser = @team_score_b
    else
      @winner = @team_score_b
      @loser = @team_score_a
    end
  end
end
