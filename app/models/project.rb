class Project < ActiveRecord::Base

    belongs_to :managers
    belongs_to :clients

    validates :name, presence: true
    validates :task, presence: true
    validates :user_id, presence: true
    validates :manager_id, presence: true



end


