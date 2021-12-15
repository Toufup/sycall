json.news @news do |a_news|
    json.id a_news.id
    json.title a_news.title
    json.createdAt l(a_news.created_at, format: "%Y/%m/%d")
end
json.pageLength @page_length if @page_length
