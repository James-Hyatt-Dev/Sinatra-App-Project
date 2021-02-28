class Manager < ActiveRecord::Base

    has_secure_password

    has_many :clients
    has_many :projects, through: :clients

end