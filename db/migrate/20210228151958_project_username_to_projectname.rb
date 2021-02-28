class ProjectUsernameToProjectname < ActiveRecord::Migration[6.1]

  def change
    rename_column :projects, :user_name, :project_name
  end

end
