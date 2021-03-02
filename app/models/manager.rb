class Manager < ActiveRecord::Base

    has_secure_password

    has_many :clients
    has_many :projects, through: :clients

    validates :name, presence: true
    validates :user_name, presence: true
    validates :email, presence: true
    validates :password_digest, presence: true

    def slug
        user_name.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        Manager.all.find{|manager| manager.slug == slug}
    end

end



