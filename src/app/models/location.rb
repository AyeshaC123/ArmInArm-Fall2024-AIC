class Location < ApplicationRecord
    validates :name, presence: true
    validates :address, presence: true
    validates :operating_hours, presence: true
    validates :operating_days, presence: true
    
end