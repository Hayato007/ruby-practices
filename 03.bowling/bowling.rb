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

point = 0
point1 = 0

point = 10.times do |n|
  frame = frames[n] # 現在のフレームのスコア
  next_frame = frames[n + 1] || [] # 次のフレームのスコア（存在しない場合は空配列）
  after_next_frame = frames[n + 2] || [] # 次の次のフレームのスコア（存在しない場合は空配列）
  left_shots = next_frame + after_next_frame # 残りの投球のスコア

  point1 += frame.sum # 現在のフレームのスコアを合計点に加算

  if frame[0] == 10 # ストライクの場合
    point1 += (left_shots.slice(0, 2)).sum # 次の2投のスコアを加算
  elsif frame.sum == 10 # スペアの場合
    point1 += (next_frame[0] || 0) # 次の1投のスコアを加算
  end
end

puts point  # 合計点を表示
puts point1  # 合計点を表示

