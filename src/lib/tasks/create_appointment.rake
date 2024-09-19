# Project name: Arm in Arm Appointment - Team 24
# Description: temporary rake task to test functionality, it adds appointent for client for the next day in the database
# Filename: create_appointment.rake
# Last modified on: 4/28/2024

#This is a temporary file that is used to test the reminder functionality due to the appointments section not working previously
#This file should be deleted in final use
namespace :appointment do
    desc "Create a new appointment for a client by first and last name"
    task :create, [:first_name, :last_name] => :environment do |t, args|
      # Find the client by first and last name
      client = Client.find_by(first_name: args[:first_name], last_name: args[:last_name])
  
      if client
        # Set the appointment for tomorrow at Princeton
        date_of_appts = Date.tomorrow
        location = 'Princeton'
        time_of_appts = '10:00 AM'  # Set a default time
  
        # Create the appointment
        appointment = client.appointments.create(
          date_of_appts: date_of_appts,
          time_of_appts: Time.zone.parse("#{date_of_appts} #{time_of_appts}"),
          location: location
        )
  
        if appointment.persisted?
          puts "Appointment successfully created for #{client.first_name} #{client.last_name} at #{location} on #{date_of_appts}."
        else
          puts "Error creating appointment: #{appointment.errors.full_messages.join(", ")}"
        end
      else
        puts "No client found with name #{args[:first_name]} #{args[:last_name]}."
      end
    end
  end
  