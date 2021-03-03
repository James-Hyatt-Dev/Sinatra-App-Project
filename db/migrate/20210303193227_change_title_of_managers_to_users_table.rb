class ChangeTitleOfManagersToUsersTable < ActiveRecord::Migration[6.1]

  def change
    rename_table :managers, :users
  end

end
