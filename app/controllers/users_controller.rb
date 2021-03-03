class UsersController < ApplicationController

  get '/users' do 
    if Helpers.is_logged_in?(session)
      @users = User.all
      @user = User.find(session[:user_id])
      erb :'users/index'
    else
      redirect to '/'
    end
  end
  
  
  get '/signup' do
    if Helpers.is_logged_in?(session)
      @user = User.find(session[:user_id])
      redirect to "/users/#{@user.slug}"
    else
      erb :'users/new'
    end
  end

  post '/signup' do
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    if @user.valid?
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    elsif @user.invalid? && User.find_by(username: @user.username)
      redirect '/signup'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      @user = Helpers.current_user(session)
      redirect to "/users/#{@user.slug}"
    else
      erb :'/users/login'
    end
  end
  
  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.slug}"
    else
      redirect '/login'
    end
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
