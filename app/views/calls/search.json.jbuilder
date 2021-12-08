translation_jp = {
    japanese: "日本語カナ表記",
    korean: "韓国語",
    romanized: "ローマ字表記",
    english: "英語",
}

json.array! @lyrics_versions do |version|
    json.id(version.id)
    json.title(version.song.title)
    json.bpm(version.song.bpm)
    json.artist(version.song.artist.name)
    json.language(translation_jp[version.language.name.intern])
    json.recommend(version.videos.find_by(tag: "recommend")&.url)
    json.guide(version.videos.find_by(tag: "guide")&.url)
    json.creator("Admin")
end
