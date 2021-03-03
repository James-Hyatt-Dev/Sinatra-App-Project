class CreateProjects < ActiveRecord::Migration[6.1]

  def change
    create_table :projects do |p|
      p.string :name
      p.string :content
      p.string :task 
      p.integer :client_id
      p.integer :manager_id
    end
  end
end
