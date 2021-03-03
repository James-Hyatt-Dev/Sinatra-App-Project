class Project < ActiveRecord::Base

    belongs_to :managers
    belongs_to :clients

    validates :name, presence: true
    validates :task, presence: true
    validates :content, presence: true





end
