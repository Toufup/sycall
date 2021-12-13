json.songs @songs do |song|
    json.id song.id
    json.song do
        json.title song.title
        json.bpm song.bpm
    end
    json.artist do 
        json.name song.artist.name
    end
end
json.pageLength @page_length
