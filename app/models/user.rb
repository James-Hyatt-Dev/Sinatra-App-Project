class User < ActiveRecord::Base

    has_secure_password

    belongs_to :managers
    belongs_to :projects

    def slug
        user_name.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        User.all.find{|user| user.slug == slug}
    end


end