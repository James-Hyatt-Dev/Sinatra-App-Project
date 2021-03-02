class RenameProjectColumnUserIdToClientId < ActiveRecord::Migration[6.1]
  
  def change
    rename_column :projects, :user_id, :client_id

  end

end
