class ProjectController < ApplicationController

    get '/projects/manager_projects' do
        if manager_logged_in?
            @projects.find_by_id(params[:id])
        else 
            erb :'/'
        end
    end

    get '/projects/create_project' do
        if !manager_logged_in?
            erb :'managers/login_manager'
        else
            erb :'projects/manager_projects'
        end
    end

    post '/projects/manager_projects' do
        if manager_logged_in?
            if params[:content] == ""
                erb :'projects/create_project'
            else
                @project = current_manager.project.build(content: params[:contect], name: params[:name], task: params[:task_list])
                if @project.save
                    redirect to "/project/#{project.id}"
                else
                    erb :'projects/create_project'
                end
            end
        else
            erb :'/'
        end
    end

    

 



    post '/projects/create_project' do
        binding.pry
        project = Project.find_by(:name => params[:name])

        if project && project.authenticate(params[:name])
            session[:name] = project.name
            erb :'projects/manager_projects'
        else
            redirect to '/manager/signup'
        end

    end


  

end