class ManagersNameToManagername < ActiveRecord::Migration[6.1]

  def change
    rename_column :managers, :name, :user_name
  end

end
