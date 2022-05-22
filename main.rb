# Start the application by running on the terminal:
# rerun 'ruby main.rb'

require 'sinatra'
require 'pry'
require 'bcrypt'
require 'httparty'

#this method bellow let me print on the terminal:
use Rack::Logger
helpers do
  def logger
    request.logger
  end
end

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

  if logged_in?
    user_id = current_user["id"]
    boards = boards_by_user(user_id)
    boards_copy = []

    boards.each do |board|
      board_copy = {"id" => board['id'].to_s, "user_id" => board['user_id'].to_s, "board_title" => board['board_title'].to_s}

      board_id = board['id']
      # logger.info("Board id: #{board_id}")
      board_images = get_images(board_id)
      board.store('images', board_images)
      board_copy.store('images', board_images)
      # logger.info("Images: #{board['images'][0]}")
      boards_copy.push(board_copy)
    end
    # logger.info("Boards: #{boards_copy[0]['id']} #{boards_copy[0]['images'][0]}")
  else
    boards = []
  end
  
  erb :'boards/index', locals: {
    board_items: board_items,
    boards: boards_copy
  }
end

delete '/board/:id' do
  id = params['id']

  delete_board(id)

  redirect '/'
end

get '/board/:id/edit' do
  id = params['id']
  board = get_board(id)
  images = get_images(id)
  board_title = params['board_title']

  #logger.info() will print on the terminal
  logger.info("id #{id}")
  logger.info("board #{board}")
  logger.info("images #{images}")

  erb :'boards/edit', locals: {
    board: board,
    board_title: board_title
  }
end

put '/board/:id' do
  id = params['id']
  board_title = params['board_title']

  #tenho que darum jeito de adc as imagens aqui
  update_board(board_title, id)

  redirect '/'
end

post '/board' do
  board_title = params['board_title']
  user_id = current_user["id"]

  insert_result = create_board(board_title, user_id)

  logger.info("board_id #{insert_result['id']}")
  
  redirect "/#{insert_result['id']}/add_picture?board_title=#{board_title}"
end

get "/:id/add_picture" do
  board_title = params['board_title']
  board_id = params['id']

  erb :'boards/new_board', locals:{
    board_title: board_title,
    board_id: board_id
  }
end

post '/:id/add_picture' do
  board_title = params['board_title']
  user_id = current_user["id"]

  image_url = params['image_url']
  board_id = params['id']

  create_images(board_id, image_url)
 
  logger.info("board_id #{board_id}")
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

get '/create_user' do
  erb :'users/new'
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
  else
    "Wrong email or password. Please try again"
  end
end


delete '/sessions' do
  session['user_id'] = nil

  redirect '/'
end

delete '/board/:id/image/:id_img' do
  id = params['id']
  id_img = params['id_img']

  # logger.info("board_id #{id}")
  # logger.info("id_img #{id_img}")

  delete_image(id_img)
  
  redirect '/'
end

