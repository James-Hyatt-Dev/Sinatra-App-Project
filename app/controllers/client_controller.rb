class ClientController < ApplicationController
  
    get '/clients/new' do
        if !client_logged_in?
            erb :'clients/new' 
        else
          redirect to '/projects'
        end
    end
  
    post '/clients/new' do
      if params[:user_name] == "" || params[:email] == "" || params[:password] == "" || params[:name] == ""
        redirect to '/client/new'
      else
        client = Client.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
        client.save
        session[:client_id] = @client.id
  
        erb :'projects'
      end
    end
  
    get '/clients/login' do
        
        if !client_logged_in?
          erb :'clients/login'
        else
         redirect to '/projects'
        end
    end
  
    post '/clients/login' do
      client = Client.find_by(:user_name => params[:user_name])
        if client && client.authenticate(params[:password])
          session[:client_id] = client.id
          projects = Project.all
          redirect to '/projects'
        else
          redirect to '/clients/login'
        end
    end
  
    get '/clients/logout' do
        if client_logged_in?
            session.destroy
            redirect to '/clients/login'
        else
            redirect to '/'
        end
    end

    get '/clients/:slug' do
        client = Client.find_by_slug(params[:slug])
        erb :'projects'
      end
    
  end
  