# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require_relative 'routes/posts'
require_relative 'routes/account'
require_relative 'routes/comments'

# For cookies
use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           secret: 'sosecret'

set :default_content_type, :json

get '/' do
  { message: 'Hello world.' }.to_json
end

get '/up' do
  { success: true }.to_json
end
