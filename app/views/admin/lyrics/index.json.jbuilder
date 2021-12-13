json.lyrics @lyrics do |lyric|
    json.id lyric.id
    json.lyrics_version do
        json.song do
            json.title lyric.lyrics_version.song.title
        end
        json.language do
            json.name lyric.lyrics_version.language.name
        end
    end
    json.lyric do 
        json.body lyric.body[0, 50]
    end
end
json.pageLength @page_length
