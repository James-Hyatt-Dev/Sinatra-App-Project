require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "relion_secret"
  end

  get "/" do
    erb :index
  end
  
  helpers do

    def logged_in?
      !!current_user  
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] ||= Manager.find_by(id: session[:manager_id]) if session[:manager_id]
    end

   
  end

  

  
end
