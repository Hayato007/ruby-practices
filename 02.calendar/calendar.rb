require 'optparse'
require 'date'

opt = OptionParser.new

options = {}

opt.on('-m VAL') {|v| options[:month] = v.to_i }
opt.on('-y VAL') {|v| options[:year] = v.to_i }

opt.parse(ARGV)

today = Date.today
year = options[:year] || today.year
month = options[:month] || today.month

unless Date.valid_date?(year, month, 1)
  puts "Error: Invalid year or month specified."
  exit
end

puts "#{Date::MONTHNAMES[month]}, #{year}".center(20)
puts "Su Mo Tu We Th Fr Sa"

start_date = Date.new(year, month, 1)
end_date = Date.new(year, month, -1)

start_date.wday.times { printf "%3s", "" }

(start_date..end_date).each do |date|
  print date.day.to_s.rjust(2) + " "

  if date.wday == 6 || date == end_date
    puts
  end
end
