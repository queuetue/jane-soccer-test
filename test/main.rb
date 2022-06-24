require "./test/unit_test_helper.rb"
require "./team_rank.rb"
require "./team_score.rb"
require "./league.rb"

class TeamRankTests < Test::Unit::TestCase
  test "to string" do
    assert_equal "Team: A Team - Rank: 10", TeamRank.new("A Team", 10).to_s
  end
end

class TeamScoreTests < Test::Unit::TestCase
  test "to string" do
    assert_equal "Team: A Team - Score: 10", TeamScore.new("A Team", 10).to_s
  end
end

class MatchTests < Test::Unit::TestCase
  test "to string" do
    assert_equal "Match Team: A Team - Score: 5 Team: B Team - Score: 2", Match.new(TeamScore.new("A Team", 5), TeamScore.new("B Team", 2)).to_s
  end

  test "tie?" do
    m = Match.new(TeamScore.new("A Team", 5), TeamScore.new("B Team", 2))
    assert_equal false, m.tie?
    m = Match.new(TeamScore.new("A Team", 3), TeamScore.new("B Team", 3))
    assert_equal true, m.tie?
  end
end

class DayTests < Test::Unit::TestCase
  test "empty to string" do
    assert_equal "Day Ranks: 0", Day.new().to_s
  end

  test "simple to string" do
    d = Day.new()
    d.enter_match TeamScore.new("A Team", 5), TeamScore.new("B Team", 2)
    assert_equal "Day Ranks: 2", d.to_s
  end

  test "seen?" do
    d = Day.new()
    d.enter_match TeamScore.new("A Team", 5), TeamScore.new("B Team", 2)
    assert_equal true, d.seen?(TeamScore.new("A Team", 1))
    assert_equal false, d.seen?(TeamScore.new("Z Team", 9))
  end
end

class LeagueTests < Test::Unit::TestCase
  test "blank to string" do
    assert_equal "", League.new().to_s
  end

  test "simple to string" do
    # We're starting to get in deep, this should migrate to integration tests, probably
    l = League.new()
    l.enter_match TeamScore.new("A Team", 5), TeamScore.new("B Team", 2)
    assert_equal "Team: A Team - Rank: 3 Team: B Team - Rank: 0", l.to_s
  end

  # Ideally, there would be a test here for the report mechanism, but that would require a
  #   refactor or dependancy injection, both a bit complex for this sample code.

end
