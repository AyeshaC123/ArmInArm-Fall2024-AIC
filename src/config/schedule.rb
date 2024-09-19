# Project name: Arm in Arm Appointment Booker - Team 14
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: schedule.rb
# Description: schedules when reminder rake task should be run
# Last modified on: 4/15/2024

every 1.day, at: '3:00 pm' do
    rake "reminder:send_reminders"
end