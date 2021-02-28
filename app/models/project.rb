class Project < ActiveRecord::Base

    belongs_to :managers
    belongs_to :clients


end