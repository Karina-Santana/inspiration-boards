# Start the application by running on the terminal:
# rerun 'ruby main.rb'

require 'sinatra'
require 'pry'
require 'bcrypt'

# this makes the session hash work
enable :sessions

# database:
require './db/db'

# models:
require './models/food'
require './models/user'

# controllers:
require './controllers/food_controller'
require './controllers/sessions_controller'
require './controllers/users_controller'

# helpers:
require './helpers/sessions_helper'



