require "./day.rb"

class League
  def initialize
    @match_days = [Day.new()]
  end

  def current_day
    @match_days.length
  end

  def match_day
    @match_days.length ? @match_days[-1] : nil
  end

  def seen?(team_score)
    @match_days.length ? (match_day.seen? team_score) : false
  end

  def day_report(final = false)
    puts "Matchday #{@match_days.length}"
    totals = {}
    @match_days.each do |day|
      day.team_ranks.each do |team_rank|
        totals[team_rank.team] = (totals[team_rank.team] || 0) + team_rank.rank
      end
    end

    totals.map { |tot| tot }
      .sort { |b, a| b[0] <=> a[0] }
      .sort { |a, b| b[1] <=> a[1] }
      .slice(0, 3)
      .each { |team, score| puts "#{team}, #{score} #{score == 1 ? "pt" : "pts"}" }
    puts "" unless final
  end

  def enter_match(ts_a, ts_b)
    # New day if we've seen one of the current teams already in the current day
    # TODO: Is there another way to guess "next day"? Do the teams change?  This is how we do it for now.
    new_day = (self.seen? ts_a) || (self.seen? ts_b)
    if new_day
      day_report(false)
      @match_days << Day.new()
    end
    match_day.enter_match(ts_a, ts_b)
  end

  def to_s
    return "" if @match_days.length == 0
    @match_days.map do |day|
      if day.team_ranks.length
        day.team_ranks.map do |team_rank|
          team_rank.to_s
        end
      else
        ""
      end
    end.join(" ")
  end
end
