#! /usr/bin/env ruby
# frozen_string_literal: true

COLUMNS = 3

def list_filenames
  Dir.glob('*')
end

def list_files_in_columns
  files = list_filenames

  rows = (files.size / COLUMNS.to_f).ceil

  rows.times do |n|
    row_items = []
    COLUMNS.times do |col|
      idx = n + col * rows
      row_items << files[idx] if idx < files.size
    end
    puts row_items.join("\t")
  end
end

list_files_in_columns
