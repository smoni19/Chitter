require 'sinatra/base'
require 'sinatra/reloader'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :'index'
  end

  get '/peeps' do
    @peeps = [
      "Hobnobs are the best biscuit",
      "Fun fact: the can opener was invented over 1000 years before the can",
      "Ignorance, the root and stem of every evil. ― Plato"
    ]
    erb :'peeps/index'
  end

  run! if app_file == $0
end
