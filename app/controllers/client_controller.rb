class ClientController < ApplicationController

    get '/clients/:slug' do
        
      @client = Client.find_by_slug(params[:slug])
      erb :'projects/client'
    end
    

    get '/clients/signup' do
        if !client_logged_in?
            erb :'clients/create' 
        else
          
          erb :'clients/client_project'
        end
    end

    post '/clients/signup' do
      

         if params[:user_name] == "" || params[:email] == "" || params[:password] == "" || params[:name] == ""
          redirect to '/client/signup'
        else
          @client = Client.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
          @client.save
          session[:user_id] = @client.id
          
          erb :'projects/client'
        end
    end

    get '/clients/login' do
        
        if !client_logged_in?
          erb :'clients/login'
        else
            erb :'projects/client'
        end
    end

    post '/client/login' do

      client = Client.find_by(:user_name => params[:user_name])
        
        if client && client.authenticate(params[:password])
          session[:user_id] = client.id
          
          erb :'projects/client'
        else
          redirect to '/clients/signup'
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



    
end



