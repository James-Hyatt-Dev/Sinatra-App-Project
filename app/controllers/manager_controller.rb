class ManagerController < ApplicationController

  
  get '/managers/:slug' do
    manager = Manager.find_by_slug(params[:slug])
    erb :'projects/show'
  end
  
  get '/signup' do
    if !logged_in?
      erb :'/new' 
    else
      redirect to '/projects'
    end
  end

  post '/signup' do
    binding.pry
    if params[:user_name] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @manager = Manager.new(:user_name => params[:user_name], :email => params[:email], :password => params[:password], :name => params[:name])
      manager.save
      session[:manager_id] = manager.id
      redirect to '/projects'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'/login'
    else
      redirect to '/projects'
    end
  end

  post '/login' do
    manager = Manager.find_by(:user_name => params[:user_name])
    if manager && manager.authenticate(params[:password])
      session[:manager_id] = manager.id
      redirect to '/projects'
    else
      redirect to '/new'
    end
  end

  get '/logout' do
    if logged_in?
        session.destroy
        redirect to '/login'
    else
        redirect to '/'
    end
  end

end
