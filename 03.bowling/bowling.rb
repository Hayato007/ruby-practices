#!/usr/bin/env ruby
# frozen_string_literal: true

shots = ARGV[0].split(',').map { |s| s == 'X' ? 10 : s.to_i }

frames = [] # フレームごとのスコアを格納する配列
frame = [] # 現在のフレームのスコアを一時的に格納する配列

shots.each do |s|
  frame << s # スコアを現在のフレームに追加

  if frames.length < 10 # 最後のフレーム以外の場合の処理
    if frame.length >= 2 || s == 10 # フレームが2投されたか、ストライクの場合
      frames << frame.dup # フレームを追加し、新しいフレームを開始
      frame.clear
    end
  else # 最後のフレームの場合
    frames.last << s # 最後のフレームにスコアを追加
  end
end

point

point = 10.times.sum do |n|
  frame = frames[n]
  if frame.sum < 10
    frame.sum
  elsif frame[0] == 10 # ストライクの場合
    if n == 9
      frame.sum
    elsif n == 8
      frame.sum + frames[n + 1][0] + frames[n + 1][1]
    elsif frames[n + 1][0] != 10
      frame.sum + frames[n + 1].sum
    else
      frame.sum + frames[n + 1][0] + frames[n + 2][0]
    end
  elsif frame.sum >= 10 # スペアの場合もしくは、１０以上
    if n < 9
      frame.sum + frames[n + 1][0] # n=8の場合ここに入る
    else
      frame.sum # 最終フレームの場合ここに入る
    end
  end
end

puts point # 最終点
