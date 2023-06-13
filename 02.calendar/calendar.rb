require 'optparse'
require 'date'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: cal.rb [options]"

  opts.on("-m", "--month MONTH", Integer, "Specify month (1-12)") do |month|
    options[:month] = month
  end

  opts.on("-y", "--year YEAR", Integer, "Specify year (1970-2100)") do |year|
    options[:year] = year
  end
end.parse!

if options[:year] && !options[:month]
  puts "Error: Month is required when specifying a year."
  exit
end

today = Date.today
year = options[:year] || today.year
month = options[:month] || today.month

if Date.valid_date?(year, month, 1)
else
  puts "Error: Invalid year or month specified."
  exit
end

date = Date.new(year, month, 1)
last_day = Date.new(year, month, -1).day

puts "#{Date::MONTHNAMES[month]}, #{year}".center(20)
puts "Su Mo Tu We Th Fr Sa"

start_date = Date.new(year, month, 1)
end_date = Date.new(year, month, -1)

date.wday.times { printf "%3s", "" }

(Date.new(year, month, 1)..Date.new(year, month, -1)).each do |date|
  print date.day.to_s.rjust(2) + " "

  if date.wday == 6 || date == end_date
    print "\n" if date != end_date
  end
end
