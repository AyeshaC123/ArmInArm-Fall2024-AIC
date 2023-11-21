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

    def create
      @appointment = Appointment.new(appointment_params)
      if @appointment.save
        # Handle successful creation, e.g., redirect or render a success message
        redirect_to appointments_path, notice: 'Appointment booked successfully!'
      else
        # Handle errors, e.g., re-render the form with error messages
        render 'booker'
      end
    end
  
    private
  
    def appointment_params
      params.require(:appointment).permit(:date_of_appts, :time_of_appts).merge(client_id: params[:client_id])
    end
end
