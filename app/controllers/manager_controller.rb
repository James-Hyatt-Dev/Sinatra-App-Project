class ManagerController < ApplicationController

    
  get '/managers/:slug' do
    manager = Manager.find_by_slug(params[:slug])
    erb :'projects/manager'
  end
    

  get '/managers/signup' do
      
    if !manager_logged_in?
      erb :'managers/create' 
    else
      erb :'projects/manager'
    end
  end

  post '/managers/signup' do
    if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/managers/signup'
    else
      manager = Manager.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
      manager.save
      
      session[:manager_id] = manager.id
      binding.pry
      
      redirect to '/managers/login'
    end
  end

  get '/managers/login' do
    if !manager_logged_in?
      erb :'managers/login'
    else
      redirect to :'/projects/manager'
    end
  end

  post '/managers/login' do
    manager = Manager.find_by(:user_name => params[:user_name])
    if manager && manager.authenticate(params[:password])
      
      session[:manager_id] = manager.id
      
      redirect to '/projects/manager'
    else
      redirect to '/managers/signup'
    end
  end

  get '/managers/logout' do
    if manager_logged_in?
      session.destroy
      redirect to '/managers/login'
    else
      redirect to '/index'
    end
  end

  get '/managers/logout' do
    if manager_logged_in?
        session.destroy
        redirect to '/managers/login'
    else
        redirect to '/'
    end
  end


end
