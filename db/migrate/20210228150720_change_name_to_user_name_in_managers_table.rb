class ChangeNameToUserNameInManagersTable < ActiveRecord::Migration[6.1]

  def change
    rename_column :projects, :name, :user_name
  end
end
