class ManagerController < ApplicationController

    
    get '/managers/:slug' do
      @user = Manager.find_by_slug(params[:slug])
      erb :'managers/show'
    end
    

    get '/manager/signup' do
        
        if !logged_in?
          erb :'managers/create_manager', locals: {message: "Please sign up before you sign in"}
        else
          erb :'projects/projects'
        end
    end

    post '/manager/signup' do
        if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
          
          redirect to '/manager/signup'
        else
          @manager = Manager.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
          @manager.save
          session[:manager_id] = @manager.id
          
          redirect to '/projects/projects'
        end
    end

    get '/manager/login' do
        if !logged_in?
          erb :'managers/login_manager'
        else
          redirect to '/show_project'
        end
    end

    post '/manager/login' do
        user = Manager.find_by(:user_name => params[:user_name])
        if manager && manager.authenticate(params[:password])
          session[:user_id] = user.id
          redirect to "/show_project"
        else
          redirect to '/manager/signup'
        end
    end

    get '/manager/logout' do
        if logged_in?
            session.destroy
            redirect to '/login'
        else
            redirect to '/'
        end
    end
    


    
end



