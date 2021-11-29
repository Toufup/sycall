json.array! @songs do |song|
    json.id song.id
    json.title song.title
    json.artistName song.artist.name
    json.bpm song.bpm
end
