class AdminPanel < ApplicationRecord
    validates :appointment_length, :max_appointment_count, :service_time, numericality: { only_integer: true, greater_than: 0 }
    validates :start_time, presence: true
    validates :end_time, presence: true
end
