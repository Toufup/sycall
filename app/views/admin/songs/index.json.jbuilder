json.songs @songs do |song|
    json.id song.id
    json.title song.title
    json.bpm song.bpm
    json.artist do 
        json.name song.artist.name
    end
end
json.pageLength @page_length
