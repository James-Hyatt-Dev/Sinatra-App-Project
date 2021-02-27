class Users < ActiveRecord::Base

    has_secure_password

    belongs_to :managers
    belongs_to :projects


end