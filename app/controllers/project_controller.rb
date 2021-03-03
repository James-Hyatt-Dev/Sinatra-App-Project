class ProjectController < ApplicationController

    get '/projects' do
        if !logged_in?
            @projects = Projects.all
            erb :'projects/show'
        else
            redirect to '/login'
        end
    end
    
    post '/projects/new' do
        if logged_in?
            erb :'projects/new'
        else
            redirect to '/login'
        end
    end

    post '/projects' do
        if logged_in?
            if params[:content] == "" || params[:task] == "" || params[:name] == ""
                redirect to '/projects/new'
            else
                @project = current_manager.projects.build(content: params[:content] task: params[:task] name: params[:name])
                if project.save
                    redirect to '/projects/new'
                end
            end
        else
            redirect to '/login'
        end
    end

    get '/projects/:id' do
        if logged_in?
            @project = Project.find_by_id(params[:id])
            erb :'projects/show_project'
        else
            redirect to '/login'
        end
    end

    get '/projects/:id/edit' do
        if logged_in?
            @project = Project.find_by_id)params[:id])
            if @project && @project.user == current_manager
                erb :'projects/edit_project'
            else
                redirect to '/projects'
            end
        else
            redirect to '/login'
        end
    end

    patch '/projects/:id' do
        if logged_in?
            if params[:content] == "" || params[:task] == "" || params[:name] == ""
                redirect to "/projects/#{params[:id]}/edit"
          else
            @project = Project.find_by_id(params[:id])
            if @project && @project.manager == current_manager
              if @project.update(content: params[:content])
                redirect to "/projects/#{@project.id}"
              else
                redirect to "/projects/#{@project.id}/edit"
              end
            else
              redirect to '/projects'
            end
          end
        else
          redirect to '/login'
        end
      end
      
end