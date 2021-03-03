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

    def client_logged_in?
      !!current_client  
    end

    def current_client
      @current_client ||= Client.find_by(id: session[:client_id]) if session[:client_id] 
    end

    def manager_logged_in?
      !!current_manager
    end

    def current_manager
      @current_manager ||= Manager.find_by(id: session[:manager_id]) if session[:manager_id]
    end
  end

end
