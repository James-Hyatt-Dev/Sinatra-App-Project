class ChangeNameToProjectNameInProjectsTable < ActiveRecord::Migration[6.1]

  def change
    rename_column :projects, :name, :project_name
  end

end
