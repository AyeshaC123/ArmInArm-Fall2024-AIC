# Project name: Arm in Arm Appointment - Team 24
# Description: Sends reminder to clients for their appointments for the next day
# Filename: reminder.rake
# Last modified on: 4/21/2024

class SendRemindersController
  # Sends reminders to clients with appointments scheduled for the next day.
  def self.send_reminders
    client = initialize_twilio_client
    tomorrow_appointments = Appointment.where(date_of_appts: Date.tomorrow)

    tomorrow_appointments.find_each do |appointment|
      # Ensure there is a client associated with the appointment
      unless appointment.client
        log_no_client(appointment.id)
        next
      end

      # Check if the phone number exists and is valid
      unless valid_phone_number?(appointment.client.phone_number)
        log_invalid_phone(appointment.client.id, appointment.client.phone_number)
        next
      end

      phone_number = format_phone_number(appointment.client.phone_number)
      message = build_message(appointment)

      begin
        response = client.messages.create(
          from: '+18884144750',  # Twilio phone number
          to: phone_number,     # Client's formatted phone number
          body: message
        )
        
        # Log the successful sending of the message
        log_success(phone_number, appointment.location, message, response)
      rescue Twilio::REST::RestError => e
        # Log any errors encountered during the message sending process
        log_failure(phone_number, e.message)
      end
    end
  end

  private

  def self.initialize_twilio_client
    Twilio::REST::Client.new(
      'AC0edfc9d66abdb3566e44f24ef7ec2b00',  # Twilio Account SID
      'f59b73fffedfec42e6de10b30b795810'   # Twilio Auth Token
    )
  end

  def self.valid_phone_number?(phone_number)
    phone_number.present? && phone_number.gsub(/[^\d+]/, '').match?(/\A(\+1)?\d{10}\z/)
  end

  def self.format_phone_number(phone_number)
    phone_number.start_with?('+1') ? phone_number : "+1#{phone_number}"
  end

  def self.build_message(appointment)
    "Hello! Just a reminder: You have an appointment at #{appointment.location} on #{appointment.date_of_appts.strftime('%I:%M %p')} tomorrow. See you there!"
  end

  # Logs successful message transmission to the terminal
  def self.log_success(phone_number, location, message, response)
    puts "Message successfully sent to #{phone_number} for appointment at #{location}."
    puts "Message: #{message}"
    puts "Twilio Response: #{response.sid}"  # Twilio's response object includes a SID that can be logged
  end

  # Logs failures if message transmission fails
  def self.log_failure(phone_number, error_message)
    puts "Failed to send message to #{phone_number}. Error: #{error_message}"
  end

  # Logs when no valid phone number is available
  def self.log_invalid_phone(client_id, phone_number)
    puts "Invalid or missing phone number for client ID #{client_id}. Provided phone number: '#{phone_number}'"
  end

  # Logs when no client is associated with an appointment
  def self.log_no_client(appointment_id)
    puts "No client associated with appointment ID #{appointment_id}."
  end
end
