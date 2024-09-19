# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: appointments_helper.rb
# Description: helper which handles the constraints for clients checking in and listing client's existing/past appointments
# Last Modified: 4/22/24

module AppointmentsHelper
    include Kaminari::PageScopeMethods
    include TimeHelperModule


    # this function is here to simply act as a kind of accessor method
    # for the portion of the code that does the listing of user appointments
    # for the check in page
    def store_current_appointment( appointment_record )
        @current_appointment_to_access = appointment_record
    end

    def get_current_appointment( )
        return @current_appointment_to_access
    end



    # here I am using an array to create a something that can be accessed with the admin
    # will see the list of users that are already checked in

    def declare_my_appointment_array( )

        # this array is to contain all apointments that have been checked by an admin
        @list_list_checked_in_appointments = [ ]

    end


    def store_checked_in_appointments( appointment_record )

        @list_list_checked_in_appointments << appointment_record

    end

    def get_checked_in_appointments( )

        return @list_list_checked_in_appointments

    end

    # client view; retrieves the current client's confirmed/checked in appointments
    def past_appt_cli_list( )
        @user = current_user
        return Appointment.where(check_in_user: true, client_id: @user.client_id).page(params[:pagePast]).per(5)
    end

    # admin view; retrieves ALL confirmed/checked in appointments
    def admin_checked_appt_list( )
        return Appointment.where(check_in_user: true).page(params[:page]).per(5)
    end

end
