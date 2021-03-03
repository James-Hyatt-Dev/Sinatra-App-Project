class ManagerController < ApplicationController

  
  get '/managers/:slug' do
    manager = Manager.find_by_slug(params[:slug])
    erb :'projects/show'
  end
  
  get '/managers/new' do
    if !manager_logged_in?
      erb :'managers/new' 
    else
      erb :'projects/show'
    end
  end

  post '/managers/new' do
    binding.pry
    if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/managers/new'
    else
      binding.pry
      manager = Manager.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
      manager.save
      
      session[:manager_id] = manager.id
       
      redirect to '/managers/login'
    end
  end

  get '/managers/login' do
    if !manager_logged_in?
      erb :'managers/login'
    else
       
      erb :'projects/show'
    end
  end

  post '/managers/login' do
    manager = Manager.find_by(:user_name => params[:user_name])
    if manager && manager.authenticate(params[:password])
      
      session[:manager_id] = manager.id
      redirect to '/projects/show'
    else
      redirect to '/managers/new'
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
