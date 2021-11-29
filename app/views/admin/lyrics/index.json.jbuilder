json.array! @lyrics do |lyric|
    json.id lyric.id
    json.lyrics_version do
        json.song do
            json.title lyric.lyrics_version.song.title
        end
    end
    json.lyric do 
        json.body lyric.body[0, 50]
    end
end
