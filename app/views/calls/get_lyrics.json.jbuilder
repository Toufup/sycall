lines = @call_lyrics.split(/\r?\n/)
json.array! lines do |line|
    match_data = line.match(/^(\[)(\d*)(:)(.*)(\])(.*)/m)
    time = match_data[2].to_f * 60 + match_data[4].to_f
    lyric = match_data[6]

    json.time time
    json.lyric lyric
end


