# routes/account.rb

require_relative '../models/account'

post '/signup' do
  account = Account.new(
    name: params[:name],
    password: params[:password],
    password_confirmation: params[:password_confirmation] || ''
  )

  if account.save
    session[:account_id] = account.id
    account.to_json
  else
    account.errors.to_json
  end
end

post '/login' do
  account = Account.find_by(name: params[:name])&.authenticate(params[:password])

  if account
    session[:account_id] = account.id
    puts "setting session #{session[:account_id]}"
    return account.to_json
  end

  halt 403, { access: :denied, error: 'Invalid name or password' }.to_json
end

get '/private' do
  auth_check do
    { message: 'This is a secret' }.to_json
  end
end

def auth_check
  return yield if session[:account_id]

  halt 403, { access: :denied }.to_json
end
