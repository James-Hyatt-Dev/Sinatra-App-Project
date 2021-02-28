class UserController < ApplicationController


    get '/signup' do 
       erb :'users/create_user'
    end


    post '/signup' do
        if params[:name] == "" || params[:email] == "" || params[:password] == ""
          redirect to '/signup'
        else
          @users = Users.new(:name => params[:name], :email => params[:email], :password => params[:password_digest])
          @users.save
          session[:user_id] = @user.id
          redirect to '/index'
        end
    end
end
