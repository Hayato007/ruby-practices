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

puts  Date.valid_date?(year, month, 1)

if Date.valid_date?(year, month, 1)
  else
    puts "Error: Invalid year or month specified."
  exit
end

date = Date.new(year, month, 1)
last_day = Date.new(year, month, -1).day

puts "#{Date::MONTHNAMES[month]}, #{year}".center(20)
puts "Su Mo Tu We Th Fr Sa"

start_date = Date.new(2023, 1, 1)
end_date = Date.new(2023, 1, 31)

date.wday.times { printf "%3s", "" }

(start_date..end_date).each do |current_date|

  print current_date.day.to_s.rjust(2) + " "

  if date.wday == 6 || current_date == last_day
    print "\n" if current_date != last_day
    date += (7 - date.wday) % 7
  else
    date += 1
  end
end
