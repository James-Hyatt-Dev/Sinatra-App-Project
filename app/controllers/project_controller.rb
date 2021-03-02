class ProjectController < ApplicationController

    get '/projects/new' do
        if !manager_logged_in?
            erb :'managers/login'
        else
            @clients = Client.all
            erb :'projects/new'
        end
    end
    
    post '/projects/new' do
        binding.pry
        @project = Project.new(:name => params[:name], :task => params[:task], :content => params[:content], :client_id => params[:client_id])
        @project.save
        erb :'projects/show'
    end
 
    get '/projects/show' do
        if manager_logged_in?
            Project.find_by_id(params[:id])
        else 
            erb :'/'
        end
    end

    post '/projects/show' do
        if manager_logged_in?
        project = Project.find_by(:id => params[:id])
            if project && project.authenticate(params[:password])
                session[:name] = project.name
                erb :'projects/manager'
            else
            redirect to '/managers/new'
            end
        end
    end
end