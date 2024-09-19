class GraphsController < ApplicationController
  require 'date'

  def wait_time_graph(location)
    current_date= Date.today
    @location=location
    @wait_times={}
    admin_panel = AdminPanel.first

    @appointments= Appointment.where(location: location, date_of_appts: current_date)


    @appointments.each do |appointment|
      hour = appointment.time_of_appts.strftime("%H:00") # Format time to extract the hour

      @wait_times[hour] ||= 0
      @wait_times[hour] += admin_panel.service_time
    end
    # Preserve original keys in the hash
    original_keys = @wait_times.keys

    # Create constant labels from 9:00 to 15:00
    @labels = (9..15).map { |hour| format('%02d:00', hour) }

    # Match data to the new labels
    @data = @labels.map { |label| @wait_times[label] || 0 }

    # Restore original keys in the hash
    @wait_times = @wait_times.transform_keys { |key| original_keys.include?(key) ? key : nil }


    respond_to do |format|
      format.html #This will render a format for later-Sourced from ROJ
      format.json { render json: @wait_times } # Optionally, respond with JSON if needed
    end
  end




  def current_date
    @cur_date=Date.today
  end

  def nassau
   wait_time_graph('Princeton')

  end
  def hudson
    wait_time_graph('Trenton')
  end
  def mobile
    wait_time_graph('Mobile')
  end
end
