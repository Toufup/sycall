json.artists @artists do |artist|
    json.id artist.id
    json.name artist.name
end
json.pageLength @page_length if @page_length
