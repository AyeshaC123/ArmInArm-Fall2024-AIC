class Appointment < ApplicationRecord
  include Kaminari::PageScopeMethods
  belongs_to :client
  # has_one :household, through: :client


  # belongs_to :admin_panel, dependent: :destroy
end
