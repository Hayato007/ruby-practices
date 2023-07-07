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

point = 10.times.sum do |n|
  frame = frames[n] # 現在のフレームのスコア
  if n < 9 # 最終フレーム以外
    if frame[0] == 10 # ストライクの場合
      if frames[n + 1] && frames[n + 2] ## 9フレーム目と10フレームがXの場合9フレームは11フレームを探してしまうので、それを抑制するコードである。
        if frames[n + 1][0] != 10 # ２フレーム目がストライクでない場合のコードを追加しなくてはいけない！！！！！！！！！# ストライク一回だけの場合は次フレームの合計のみを取得すれば良い
         frame.sum + frames[n + 1].sum
        else  #１フレームと2フレーム目がストライクの場合、３フレーム目の情報が必要
          frame.sum + frames[n + 1].sum + frames[n + 2][0] # ストライクの場合、次のフレームの投球を取得しなければいけないが,２フレーム先まで取得してしまっているため、点数に差異が生じる。
        end
      else
        frame.sum + frames[n + 1][0] + frames[n + 1][1]
      end
    elsif frame.sum == 10 # スペアの場合
      frame.sum + frames[n + 1][0]
    else # 最終フレームの場合
      frame.sum
    end
  else # 最終フレームの場合
    frame.sum
  end
end

puts point # 合計点を表示
