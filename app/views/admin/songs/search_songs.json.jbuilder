json.songs @songs do |song|
    json.id song.id
    json.title song.title
    json.artist do 
        json.name song.artist.name
    end
end
