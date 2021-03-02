class UserController < ApplicationController

    get '/users/:slug' do
        
      @user = User.find_by_slug(params[:slug])
      erb :'projects/user'
    end
    

    get '/user/signup' do
        if !user_logged_in?
            erb :'users/create', locals: {message: "Please sign up before you sign in"}
        else
          
          erb :'users/user_project'
        end
    end

    post '/user/signup' do
      

         if params[:user_name] == "" || params[:email] == "" || params[:password] == "" || params[:name] == ""
          redirect to '/user/signup'
        else
          @user = User.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
          @user.save
          session[:user_id] = @user.id
          
          erb :'projects/user'
        end
    end

    get '/user/login' do
        
        if !user_logged_in?
          erb :'users/login'
        else
            erb :'projects/user'
        end
    end

    post '/user/login' do

        user = User.find_by(:user_name => params[:user_name])
        
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          
          erb :'projects/user'
        else
          redirect to '/user/signup'
        end
    end

    get '/user/logout' do
        if user_logged_in?
            session.destroy
            redirect to '/user/login'
        else
            redirect to '/'
        end
    end



    
end



