json.array! @lyrics_versions do |version|
    json.id(version.id)
    json.title(version.song.title)
    json.bpm(version.song.bpm)
    json.artist(version.song.artist.name)
    json.language(version.language.name)
    json.recommend(version.videos.find_by(tag: "recommend")&.url)
    json.official(version.videos.find_by(tag: "official")&.url)
    json.creator("Admin")
end
