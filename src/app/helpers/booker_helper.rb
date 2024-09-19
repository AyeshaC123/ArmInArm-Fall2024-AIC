# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: booker_helper.rb
# Description: Contains helper methods for appointment booking.
# Last Modified: 4/22/24
module BookerHelper

    include Kaminari::PageScopeMethods

    include TimeHelperModule


    def get_the_event( id_string )

        id_string = id_string.to_i

        # getting the event
        AdminPanel.find_by( id: id_string )

    end


    # function will retrieve appointments where client has not selfed checked in
    # These will be used to display "existing appointments"
    def cli_cur_appt_retrieve( )
        return Appointment.where(client_self_check_in: false, client_id: @client.id).page(params[:pageCur]).per(8)
    end

    

    # collects appointments where either admin or client had checked the appointment
    def past_appt_cli_list( )
        return Appointment.where(client_id: @client.id).where("client_self_check_in = ? OR check_in_user = ?", true, true).page(params[:pagePast]).per(5)

    end

    def did_event_pass( appointment )

        return ( Time.current.in_time_zone('Eastern Time (US & Canada)') ) < ( add_date_to_time( appointment.time_of_appts, appointment.date_of_appts ) )

    end
end
