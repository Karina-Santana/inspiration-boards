# Start the application by running on the terminal:
# rerun 'ruby main.rb'

require 'sinatra'
require 'pry'
require 'bcrypt'

# this makes the session hash work
# enable :sessions

# database:
require './db/db'

# models:
require './models/board'
require './models/user'

# # controllers:
# require './controllers/food_controller'
# require './controllers/sessions_controller'
# require './controllers/users_controller'

# # helpers:
# require './helpers/sessions_helper'

# https://api.unsplash.com/photos/?client_id=YOUR_ACCESS_KEY

#access key: 9hMYlaUVfo1Ka2sq_gvgTNrDj5h7tCW8YZO8eDkW1KQ
#secret key: nsR7l0G4Gh9lUozGIE9sv66av9KDyX8WavFUuZl878E


get '/' do
  board_items = all_photos()
  # binding.pry
  erb :'boards/index', locals: {
    board_items: board_items
  }
end

get '/sign_up' do
  erb :'users/new'
end

post '/create_user' do
  name = params['name']
  email = params['email']
  password = params['password']

  create_user(name, email, password)

  redirect '/'
end

get '/login' do
  erb :'sessions/new'
end

post '/sessions' do
  email = params['email']
  password = params['password']

  user = find_user_by_email(email)

  if user && BCrypt::Password.new(user['password_digest']) == password

    session['user_id'] = user['id']
    redirect '/'
  end
end

# get '/sessions' do
#   "Hello World"
# end

delete '/sessions' do
  session['user_id'] = nil

  redirect '/'
end

get '/show_results' do
  keyword = params['keyword']
  client_id = params['client_id']

  image_search = HTTParty.get("https://api.unsplash.com/search/photos/?client_id=9hMYlaUVfo1Ka2sq_gvgTNrDj5h7tCW8YZO8eDkW1KQ")

  if image_search.empty?
      "<h1>Sorry, no pictures for this search</h1>"
  else
      erb :show, locals: {
        keyword: keyword,
        image_search: image_search
      }
  end
end

