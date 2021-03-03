class RemoveClientIdFromProjectsTable < ActiveRecord::Migration[6.1]

  def change
    remove_column :projects, :client_id
  end

end
