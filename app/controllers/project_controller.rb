class ProjectController < ApplicationController

    get '/projects' do
        if manager_logged_in?  
            if @projects = Project.all
                redirect to '/projects/projects'
            else 
                redirect to '/managers/login'
            end
        elsif client_logged_in?
            if @projects = Project.all
                redirect to '/projects/projects'
            else
                redirect to '/clients/login'
            end
        end
    end

    get '/projects/new' do
        if logged_in?
            @clients = Client.all
            erb :'projects/new'
        else
            redirect to '/'
        end
    end

    post '/projects/new' do
        if params[:name] == "" || params[:task] == "" || params[:content] == ""
            redirect to '/projects/new'
        elsif  
            project = Project.new(:name =>params[:name], :task => params[:task], :content => params[:content], :client_id => params[:client_id])
            project.manager_id = session[:manager_id] 
            project.save
            @projects = Project.all
            @managers = Manager.all
            @clients = Client.all
            redirect to '/projects/projects'
        elsif
            if !manager_logged_in?
                redirect to '/managers/login'
            end
        elsif
            if !client_logged_in?
                redirect to '/clients/login'
            end
        end
        
    end

    post '/projects' do
        if manager_logged_in? || client_logged_in?
            if params[:content] == "" || params[:task] == "" || params[:name] == ""
                redirect to '/projects/new'
            else
                
                @project = current_manager.projects.build(content: params[:content], task: params[:task], name: params[:name], client_id: params[:client_id])
                if @project.save
                    redirect to "/projects/#{@project.id}"
                else
                    redirect to '/projects/new'
                end
            end
        else
            redirect to 'login'
        end
    end

    get '/projects/:id' do
        @project = Project.find_by_id(params[:id])
        redirect to '/projects'
    end


    get '/projects/:id/edit' do
        if logged_in?
            @project = Project.find_by_id(params[:id])
            if @project && @project.manager == current_manager
                erb :'projects/edit'
            else
                redirect to '/projects'
            end
        else
            redirect to '/'
        end
    end

    patch '/projects/:id' do
        if manager_logged_in? || client_logged_in?
            if params[:content] == "" || params[:task] == "" || params[:name] == ""
                redirect to "/projects/#{params[:id]}/edit"
            else
                @project = Project.find_by_id(params[:id])
                if @project && @project.manager == current_manager
                    if @project.update(content: params[:content], task: params[:task], name: params[:name])
                        redirect to "projects/#{@project.id}"
                    else
                        redirect to "/projects/#{@project.id}/edit"
                    end
                else 
                    redirect to '/projects'
                end
            end
        else
            redirect to '/index'
        end
    end

    delete '/projects/:id/delete' do
        if manager_logged_in? || client_logged_in?
            @project = Project.find_by_id(params[:id])
            if @project && @project.manager == current_manager
                @project.delete
            end
            redirect to '/projects'
        else
            redirect to '/index'
        end
    end
end