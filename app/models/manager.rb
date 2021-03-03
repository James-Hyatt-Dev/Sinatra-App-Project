class Manager < ActiveRecord::Base

    has_secure_password

    has_many :projects

    validates :name, presence: true, uniqueness: true
    validates :user_name, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true

    

end



