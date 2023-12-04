# Project name: Arm in Arm Appointment Booker - Team 14 / 21
# Description: Model for the admin panel
# Filename: admin_panel.rb
# Description: Admin panel created by teams 14 and 21 to allow the arm in arm staff to interact with the appointment booking process
# Last modified on: 11/29/23


class AdminPanel < ApplicationRecord
    validates :appointment_length, :max_appointment_count, :service_time, numericality: { only_integer: true, greater_than: 0 }
    validates :start_time, presence: true
    validates :end_time, presence: true
end
