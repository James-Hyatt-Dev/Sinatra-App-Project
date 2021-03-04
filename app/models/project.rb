class Project < ActiveRecord::Base

    belongs_to :managers
    belongs_to :clients

    validates :name, presence: true
    validates :task, presence: true
    validates :content, presence: true


    def slug
        user_name.downcase.gsub(" ","-")
    end
    
    def self.find_by_slug(slug)
        Project.all.find{|project| project.slug == slug}
    end


end
