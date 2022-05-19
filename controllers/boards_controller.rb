get '/' do
    erb :'boards/index', locals: {
        board_items: board_items
    }
end

get '/show_results' do
    keyword = params['keyword']

    image_search = HTTParty.get("")

    if image_search.empty?
        "<h1>Sorry, no pictures for this search</h1>"
    else
        erb :show, locals: {
            keyword: keyword,
            image_search: image_search
        }
    end
end

