class CreateManagers < ActiveRecord::Migration[6.1]

  def change
    create_table :managers do |p|
      p.string :name
      p.string :email
      p.string :password_digest
    end
  end
end
