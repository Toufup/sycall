json.array! @songs do |song|
    json.id song.id
    json.song do
        json.title song.title
    end
    json.artist do 
        json.name song.artist.name
    end
end
