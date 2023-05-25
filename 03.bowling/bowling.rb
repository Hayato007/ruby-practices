#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []

# xの数字（shots）を分けている
scores.each do |sp|
  if sp == 'X'
    shots << 10
    shots << 0
  else
    shots << sp.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

#次のフレームの一頭目の数字を取ることに成功！
frames.each_with_index do |n, idx|
    p [n, idx]
    hoshi_frame = idx.next if n.sum==10

    p frames[hoshi_frame][0] if n.sum==10 && idx != 9
    puts
end
# p frames
#  p frames[3][0]

# 10フレーム目がxだった場合


point = 0
frames.each do |first, second|
  if first == 10 # strike
    point += 30
  elsif first + second == 10 # spare
    point += first + 10
  else
    point += first + second
  end
end
puts point
