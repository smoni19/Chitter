require "sinatra/base"
require "sinatra/reloader"
require "./lib/peep"
require "./lib/account"

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  enable :sessions, :method_override

  get "/" do
    @peeps = Peep.all
    @name = session[:name]
    @username = session[:username]
    @user = Account.find(id: session[:user_id])
    erb :index
  end

  post "/post_peep" do
    Peep.create(text: params[:text], post_time: Time.new, account_id: session[:id])
    redirect back
  end

  get "/signup" do
    erb :"account/new"
  end

  post "/signup" do
    @user = Account.create(name: params[:name],
    username: params[:username],
    email: params[:email],
    password: params[:password])
    session[:name] = @user.name
    session[:username] = @user.username
    session[:email] = @user.email
    session[:id] = @user.id
    redirect "/"
  end

  get "/login" do
    erb :"account/login"
  end

  post "/login" do
    @user = Account.login(email: params[:email], password: params[:password])
    session[:name] = @user.name
    session[:username] = @user.username
    session[:email] = @user.email
    session[:id] = @user.id
    redirect "/"
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  get "/users/:username" do
    @peeps = Peep.all
    @name = session[:name]
    @username = session[:username]
    @profile = params[:username]
    erb :"account/profile"
  end

  get "/hashtag/:hashtag" do
    @peeps = Peep.all
    @name = session[:name]
    @username = session[:username]
    @profile = params[:username]
    @hashtag = params[:hashtag]
    erb :"peeps/hashtag"
  end

  get "/edit/:id" do
    @name = session[:name]
    @username = session[:username]
    @peep = Peep.find(id: params[:id])
    erb :"peeps/edit"
  end

  patch "/update/:id" do
    Peep.edit(id: params[:id], text: params[:edited_text])
    redirect "/"
  end

  delete "/delete/:id" do
    Peep.delete(id: params[:id])
    redirect "/"
  end

  run! if app_file == $0
end
