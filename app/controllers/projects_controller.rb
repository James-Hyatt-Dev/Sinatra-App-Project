class ProjectController < ApplicationController

    get '/projects' do
        if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
        @projects = Projects.all
        erb :'/projects/index'
        else
            redirect to '/'
        end
    end

    get '/projects/new' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @projects = Projects.all
            erb:'/projects/new'
        else
            redirect to '/'
        end
    end

    post '/projects' do
        if params[:projects] != nil
            params[:projects].each do |project|
              @project = Project.create(user_id: session[:user_id])
              @project.user_ids = user
              @project.save
            end
        else
            redirect to '/projects/new'
        end
        redirect to "users/'#{@project.user.slug}"
    end

    get '/projects/:id' do
        if Helpers.is_logged_in?(session)
            @project = Project.find(params[:id])
            erb :'/projects/show'
        else
            redirect to '/'
        end
    end

    get '/projectss/:id/edit' do
        if Helpers.is_logged_in?(session)
            @user = Helpers.current_user(session)
            @project = Project.find(params[:id])
        if @user.projects.include?(@project)
            erb:'/projects/edit'
        else
            redirect to '/projects'
        end
        else
           redirect to '/'
        end
    end

    patch '/projects/:id' do
        @project = Project.find(params[:id])
        if @project.user == Helpers.current_user(session)
            @project.description = params[:description]
            @project.save
            redirect to "/users/#{@project.user.slug}"
        else
           redirect to '/projects'
        end
    end

    delete '/projects/:id/delete' do
        @project = Project.find(params[:id])
    if Helpers.is_logged_in?(session)
        @user = Helpers.current_user(session)
        if @user.projects.include?(@project)
            @project.delete
            redirect to "users/#{@user.slug}"
        else
             redirect to '/projects'
        end
    else
        redirect to '/'
    end
    end
end

