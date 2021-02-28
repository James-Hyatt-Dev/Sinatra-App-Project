class UserController < ApplicationController

    # get '/users/:slug' do
        
    #   @user = User.find_by_slug(params[:slug])
    #   erb :'users/show_user'
    # end
    

    get '/user/signup' do
        
        if !logged_in?
          erb :'users/create_user', locals: {message: "Please sign up before you sign in"}
        else
          redirect to '/show_project'
        end
    end

    post '/user/signup' do
        
        if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/user/signup'
        else
          @user = User.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password])
          @user.save
          session[:user_id] = @user.id
          redirect to '/hell'
        end
    end

    get '/user/login' do
        
        if !logged_in?
          erb :'users/login_user'
        else
          redirect to '/show_project'
        end
    end

    post '/user/login' do

        user = User.find_by(:user_name => params[:user_name])
        
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/show_project"
        else
          redirect to '/user/signup'
        end
    end

    get '/user/logout' do
        if logged_in?
            session.destroy
            redirect to '/hello'
        else
            
            redirect to '/'
        end
    end


    
end



