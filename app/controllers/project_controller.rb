class ProjectController < ApplicationController

    get '/projects/manager' do
        if manager_logged_in?
            @projects.find_by_id(params[:id])
        else 
            erb :'/index'
        end
    end

    get '/projects/create' do
        if !manager_logged_in?
            erb :'managers/login'
        else
            @users = User.all
            erb :'projects/create'
        end
    end

    post '/projects/manager' do
        if manager_logged_in?
            if params[:content] == ""
                erb :'projects/create'
            else
                @project = current_manager.project.build(content: params[:contect], name: params[:name], task: params[:task_list])
                if @project.save
                    redirect to "/project/#{project.id}"
                else
                    erb :'projects/create'
                end
            end
        else
            erb :'/'
        end
    end



 



    post '/projects/create' do
        
        project = Project.find_by(:name => params[:name])

        if project && project.authenticate(params[:name])
            session[:name] = project.name
            erb :'projects/manager'
        else
            redirect to '/manager/signup'
        end

    end


  

end