class ChangeColumnNameInProjectsTable < ActiveRecord::Migration[6.1]

  def change
    rename_column :projects, :client_id, :user_id
  end

end
