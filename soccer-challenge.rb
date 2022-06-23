#!/usr/bin/env ruby

file = nil

teams = {}
days = []

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

file.each { |line|
  matches = line.scan(/[,\n ]*([a-zA-Z ]+) (\d+)/)

  # skip invalid lines
  next unless matches

  # New day if we've seen one of the current teams already in the current day
  # TODO: Is there another way to guess "next day"? Do the teams change?  This is how we do it for now.

  if (days.length < 1) || (days[-1][:teams].include? matches[0][0]) || (days[-1][:teams].include? matches[1][0])
    if days.length > 0
      puts "Matchday #{days.length}"
      teams.sort { |a, b| b[1] <=> a[1] }[0..2].each do |team|
        puts "#{team[0]} #{team[1]} pts"
      end
      puts ""
    end
    days << { teams: [] }
  end

  days[-1][:teams] << matches[0][0]
  days[-1][:teams] << matches[1][0]

  if matches[0][1] == matches[1][1]
    teams[matches[0][0]] = (teams[matches[0][0]] || 0) + 1
    teams[matches[1][0]] = (teams[matches[0][0]] || 0) + 1
  else
    teams[matches[0][0]] = (teams[matches[0][0]] || 0) + 3
  end
}
