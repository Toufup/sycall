json.song do
    json.id @lyrics_version.song.id
    json.title @lyrics_version.song.title
end
json.lyrics_version do
    json.source @lyrics_version.source
end
json.language do
    json.name @lyrics_version.language.name
end
json.video do
    json.recommend do
        json.url @lyrics_version.videos.find_by(tag: "recommend")&.url
    end
    json.guide do
        json.url @lyrics_version.videos.find_by(tag: "guide")&.url
    end
end
