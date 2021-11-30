json.lyrics_version do
    json.id @lyric.lyrics_version.id
    json.song do
        json.title @lyric.lyrics_version.song.title
        json.artist do
            json.name @lyric.lyrics_version.song.artist.name
        end
    end
    json.language do
        json.name @lyric.lyrics_version.language.name
    end
end
json.lyric do 
    json.body @lyric.body
end
