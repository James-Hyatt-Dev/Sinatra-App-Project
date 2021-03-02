class ManagerController < ApplicationController

    
  get '/managers/:slug' do
    @manager = Manager.find_by_slug(params[:slug])
    erb :'managers/manager_projects'
  end
    

  get '/manager/signup' do
      
    if !manager_logged_in?
      erb :'managers/create_manager', locals: {message: "Please sign up before you sign in"}
    else
      erb :'projects/manager_projects'
    end
  end

  post '/manager/signup' do
    if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/manager/signup'
    else
      @manager = Manager.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
      @manager.save
      binding.pry
      session[:manager_id] = @manager.id
      binding.pry
      
      erb :'projects/manager_projects'
    end
  end

  get '/manager/login' do
    if !manager_logged_in?
      erb :'/managers/login_manager'
    else
      erb :'/managers/manager_projects'
    end
  end

  post '/manager/login' do
    manager = Manager.find_by(:user_name => params[:user_name])
    if manager && manager.authenticate(params[:password])
      binding.pry
      session[:manager_id] = Manager.id
      redirect to "/manager_projects"
    else
      redirect to '/manager/signup'
    end
  end

  get '/manager/logout' do
    if manager_logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end
