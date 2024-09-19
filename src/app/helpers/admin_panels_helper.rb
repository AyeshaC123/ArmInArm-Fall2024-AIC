module AdminPanelsHelper

    def prepare_for_temp_arrays( )

        @start = 0
        @end = @start + 2
        @temp_array = [ ]

    end

    def update_start_end

        @start = @start + 3
        @end = @start + 2

    end

    def set_up_temp_array( event_list )

        @temp_array = event_list.to_a()[ @start..@end ]
        # puts( @temp_array.inspect )

        update_start_end( )

    end

    def get_temp_array( )

        return @temp_array

    end


    def reservation_count( event_id )
        # this function is returning the total appoitnments there are so far for an event
        Appointment.where( admin_panels_id: event_id ).count( )

    end


    def send_card( admin_panel_event )
        
        # this is simply to help with passing values through the partials
        @current_event_card = admin_panel_event

    end


    def get_card( )

        return @current_event_card
    end
end