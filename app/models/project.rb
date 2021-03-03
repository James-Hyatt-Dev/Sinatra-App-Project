class Project < ActiveRecord::Base

    belongs_to :managers
 
    validates :name, presence: true
    validates :task, presence: true
    validates :content, presence: true





end


