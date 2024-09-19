# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: time_help_module.rb
# Description: helper which handles comparing appointment times (in UTC) with current times (in EDT or EST)
# Last Modified: 4/24/24

module TimeHelperModule
    # This constant specifies the hours behind EDT and EST are from UTC
    EDT_OFFSET = 4
    EST_OFFSET = 5
   
    # Checks that the current time is within [appointment start - 10min, appointment end]
    def on_time?( appointment_record )

        admin_panel = AdminPanel.find_by(id: appointment_record.admin_panels_id)
        check_in_grace_period = admin_panel.check_in_grace_period
        appointment_length = admin_panel.appointment_length
        time = appointment_record.time_of_appts
        date = appointment_record.date_of_appts
        current_time = Time.current
        appt_datetime = add_date_to_time(time, date)

        return (current_time.advance(minutes: check_in_grace_period) >= appt_datetime and current_time <= appt_datetime.advance(minutes: appointment_length))

    end



    def add_date_to_time(time, date)
        return time.change(day: date.day, month: date.month, year: date.year)

    end

    def in_local_time(time)
        if Time.now.zone == 'EDT'
            local_time = time + EDT_OFFSET.hours
        else
            local_time = time + EST_OFFSET.hours
        end
        return local_time
    end
end
