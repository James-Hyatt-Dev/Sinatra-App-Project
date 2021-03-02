class Client < ActiveRecord::Base

    has_secure_password

    belongs_to :managers
    belongs_to :projects

    validates :name, presence: true
    validates :user_name, presence: true
    validates :email, presence: true
    validates :password_digest, presence: true
 

    def slug
        user_name.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        Client.all.find{|client| client.slug == slug}
    end


end