class Appointment < ApplicationRecord
    belongs_to :client
    # validates :date_of_appts, :time_of_appts, presence: true
end