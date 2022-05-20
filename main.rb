# Start the application by running on the terminal:
# rerun 'ruby main.rb'

require 'sinatra'
require 'pry'
require 'bcrypt'
require 'httparty'

# this makes the session hash work
enable :sessions

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
require './helpers/sessions_helper'

# https://api.unsplash.com/photos/?client_id=YOUR_ACCESS_KEY

#access key: 9hMYlaUVfo1Ka2sq_gvgTNrDj5h7tCW8YZO8eDkW1KQ
#secret key: nsR7l0G4Gh9lUozGIE9sv66av9KDyX8WavFUuZl878E




get '/' do
  board_items = home_photos()

  erb :'boards/index', locals: {
    board_items: board_items
  }
end

post '/board' do
  board_title = params['board_title']


  redirect "/add_picture?board_title=#{board_title}"
end

get '/add_picture' do
  board_title = params['board_title']


  erb :'boards/new_board', locals:{
    board_title: board_title
  }
end

post '/add_picture' do
  board_title = params['board_title']
  image_url = params['image_url']

  create_board(board_title, image_url)
 
  redirect '/'
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


delete '/sessions' do
  session['user_id'] = nil

  redirect '/'
end

