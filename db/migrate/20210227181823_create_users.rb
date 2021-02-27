class CreateUsers < ActiveRecord::Migration[6.1]

  def change
    create_table :users do |p|
      p.string :name
      p.string :email
      p.string :password_digest
      p.integer :manager_id
    end
  end
end
