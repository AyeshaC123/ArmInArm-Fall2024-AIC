# Project name: Arm in Arm Appointment - Team 24
# Description: rake task to be called by schedule.rb, calls send_reminder_control class
# Filename: reminder.rake
# Last modified on: 4/15/2024

require 'twilio-ruby'

namespace :reminder do
  desc "Send appointment reminders for the next day"
  task send_reminders: :environment do
    # Call to SendRemindersController to execute the reminder sending process
    SendRemindersController.send_reminders
  end
end
