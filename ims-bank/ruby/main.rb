require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :protection, :except => :frame_options
set :bind, '0.0.0.0'
set :port, 8080
set :database, {adapter: "sqlite3", database: "Database.sqlite3"}

get '/' do
  # Your implementation goes here
  erb :table
end