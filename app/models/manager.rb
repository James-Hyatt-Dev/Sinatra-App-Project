class Manager < ActiveRecord::Base

    has_secure_password

    has_many :clients
    has_many :projects, through: :clients

    def slug
        username.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
    end
    
end