class ChangeNameOfTaskListColumnToTask < ActiveRecord::Migration[6.1]

  def change
    rename_column :projects, :task_list, :task
  end

end
