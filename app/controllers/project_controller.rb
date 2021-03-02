class ProjectController < ApplicationController

    get '/projects/manager' do
        if manager_logged_in?
            Project.find_by_id(params[:id])
        else 
            erb :'/index'
        end
    end

    get '/projects/create' do
        binding.pry
        if !manager_logged_in?
            erb :'managers/login'
        else
            @clients = Client.all
            erb :'projects/create'
        end
    end

    post '/projects/manager' do
        if manager_logged_in?
            if params[:content] == ""
                erb :'projects/create'
            else
                @project = current_manager.project.build(content: params[:content], name: params[:name], task: params[:task])
                if @project.save
                    redirect to "/projects/#{project.id}"
                else
                    erb :'projects/create'
                end
            end
        else
            erb :'/'
        end
    end

    def all_projects
        @all_projects = Projects.all
    end



 



    post '/projects/create' do
        binding.pry
        project = Project.find_by(:id => params[:id])

        if project && project.authenticate(params[:password])
            session[:name] = project.name
            erb :'projects/manager'
        else
            redirect to '/managers/signup'
        end

    end


  

end