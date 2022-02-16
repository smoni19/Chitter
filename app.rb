require 'sinatra/base'
require 'sinatra/reloader'
require './lib/peep'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    @peeps = Peep.all
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
    redirect '/'
  end

  run! if app_file == $0
end
