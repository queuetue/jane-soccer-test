#!/usr/bin/env ruby

require "./league.rb"
require "./team_score.rb"

file = nil
league = League.new

case ARGV.length
when 0
  if STDIN.tty?
    puts "You must provide a filename or data to process on stdin."
    exit 1
  end
  file = $stdin
when 1
  filename = ARGV[0] || "sample-input.txt"

  unless File.exist? filename
    puts "soccer-challenge: #{ARGV[0]}: No such file or directory"
    exit 1
  end
  file = File.new(filename)
end

unless file
  puts "There was a problem accessing the data."
  exit 1
end

begin
  file.each { |line|
    competitors = line.scan(/[,\n ]*([a-zA-Z ]+) (\d+)/)
    # skip invalid lines (ones that don't match regex)
    next unless competitors

    team_result_a = TeamScore.new(competitors[0][0], competitors[0][1])
    team_result_b = TeamScore.new(competitors[1][0], competitors[1][1])

    league.enter_match team_result_a, team_result_b
  }
  file.close()
rescue
  # just do the report and get out if the stream terminates, no rescue required
end

league.day_report(true)
