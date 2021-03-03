class ProjectController < ApplicationController

    get '/projects' do
        if manager_logged_in? || client_logged_in?
            @projects = Project.all
            erb :'projects/projects'
        else
            redirect to '/manager/login/'
        end
    end

    get '/projects/new' do
        if manager_logged_in? || client_logged_in?
            erb :'projects/new'
        else
            redirect to '/index'
        end
    end

    post '/projects' do
        if manager_logged_in? || client_logged_in?
            if params[:content] == "" || params[:task] == "" || params[:name] == ""
                redirect to '/projects/new'
            else
                binding.pry
                @project = current_manager.projects.build(content: params[:content], task: params[:task], name: params[:name])
                if @project.save
                    redirect to "/projects/#{@project.id}"
                else
                    redirect to 'projects/new'
                end
            end
        else
            redirect to 'login'
        end
    end

    get 'projects/:id/edit' do
        if manager_logged_in || client_logged_in?
            @project = Project.find_by_id(params[:id])
            if @project && @project.manager == current_manager
                erb :'project/edit'
            else
                redirect to '/projects'
            end
        else
            redirect to '/index'
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