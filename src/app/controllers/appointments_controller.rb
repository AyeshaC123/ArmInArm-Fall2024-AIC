class AppointmentsController < ApplicationController
    def index
      # The built-up parts of the WHERE clause.
      where = []
      # The values to match in the database.
      values = []
      # Add ID to filter if requested.
      if params[:id].present?
        where.push "id = ?"
        values.push params[:id]
      end
      # Add first name to filter if requested.
      if params[:first_name].present?
        where.push "first_name ilike ?"
        values.push params[:first_name]
      end
      # Add last name to filter if requested.
      if params[:last_name].present?
        where.push "last_name ilike ?"
        values.push params[:last_name]
      end
      if where.empty?
        # No search.
        @has_searched = false
        @clients = Client.none
      else
        # Do search.
        @has_searched = true
        @clients = Client.where([where.join(' and ')] + values)
      end
    end

    def new
      @appointment = Appointment.new
    end

    def create
      aparams = appointment_params
      puts aparams
      @appointment = Appointment.new(aparams.merge(client_id: params[:client_id]))
      @appointment = Appointment.new(aparams.merge(dob: params[:dob]))

      # @appointment = Appointment.new(aparams.merge(
      #   client_id: params[:client_id],
      #   dob: @client.dob,
      #   last_name: @client.last_name
      # ))


      # @appointment = Appointment.new(aparams.merge(client_id: params[:client_id], dob: params[:dob], last_name: params[:last_name]))
      # @client = Client.find(params[:client_id])
      # @appointment = Appointment.new(aparams)
      if @appointment.save
        puts "in save"
        redirect_to appointments_path, notice: 'Appointment booked successfully!'
      else
        puts @appointment.errors.full_messages
        flash.now[:alert] = "Failed to create appointment."
        render 'booker'
      end
    end
  
    private
  
    def appointment_params
      params.require(:date_of_appts)
      params.require(:time_of_appts)
      params.require(:location)
      params.permit(
        :date_of_appts,
        :time_of_appts,
        :location,
        :client_id,
        :last_name,
        :dob
        )
    end
end
