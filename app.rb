require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'
require './lib/account'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions

  get '/' do
    @peeps = Peep.all
    @name = session[:name]
    erb :index
  end

  post '/post_peep' do
    Peep.create(text: params[:text])
    redirect '/'
  end

  get '/account/new' do
    erb :"account/new"
  end

  post '/account/new' do
    @user = Account.create(name: params[:name], username: params[:username], email: params[:email], password: params[:password])
    session[:name] = @user.name
    session[:username] = @user.username
    session[:email] = @user.email
    redirect '/'
  end

  run! if app_file == $0
end
