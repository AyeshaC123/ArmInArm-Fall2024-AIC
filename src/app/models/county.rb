class County < ApplicationRecord
  validates :county_name, presence: true
  validates :state_name, presence: true
end
