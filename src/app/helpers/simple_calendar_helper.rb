# this is simply to extend the functinoality of the gem
module SimpleCalendarHelper
    
    def set_up_event_dates( )
      
 
        # this makes sure to only get the active events
        @admin_panel = AdminPanel.where( event_active: true )
    
        # I need to get a list of all the dates that have events
        @all_event_dates = [ ]                                                           # REMOVE

        # this will be a has that contains a set of date arrays, with the
        # keys being the event id's from which the date come from
        @hash_event_dates = Hash.new
    
        @admin_panel.each do | event |
    
          # for the appointment in question get their location that they are happening at
          # and see if the users location is in this list.

          # if so the go ahead and get this list
          if ( event.location.reject { |day| day == '0' }.join(', ').to_s.downcase.include? current_user.client.default_location.downcase )
            @hash_event_dates[ event.id ] = [ ]
            event_dates = get_event_dates_from_record( event )
      
            @all_event_dates = @all_event_dates + event_dates                              # REMOVE


            @hash_event_dates[ event.id ] = @hash_event_dates[ event.id ] + event_dates

          end
      
        end
   Rails.logger.debug "Hashed Event Dates: #{@hash_event_dates.inspect}"
  
    
    end

    def get_event_dates( )

        return @all_event_dates
    end

    def set_event_id_array(  )

        @event_id_array = [ ]
        
    end

    def add_to_event_id_array( id )

      # this adds the idd of the event for the dat in question into the array

      if @event_id_array.include? id
        # do nothing, do not add to the array if the id already exists
      else
        @event_id_array << id
      end
      

    end

    def get_event_id_array( )

      return @event_id_array
    
    end

    def get_hashed_dates_array( )

      return @hash_event_dates
      
    end


    def get_event_dates_from_record( event )

        # this will contain all the dates for this event given
        date_list = [ ]
        
        start_date = event.start_date
        end_date = event.end_date
  
        # checking the array of days for the event and checking what date has these
        # days in the range that I am given
  
        # This could be performed also when the event is created so that this does not have to be done
        # everytime the appointments page is loaded up
        event.booking_days.reject { |day| day == '0' }.each do | day |
  
          case day
          when "Monday"
            date_list = date_list + (start_date..end_date).select { |date| date.monday? }
  
          when "Tuesday"
            date_list = date_list + (start_date..end_date).select { |date| date.tuesday? }
  
          when "Wednesday"
            date_list = date_list + (start_date..end_date).select { |date| date.wednesday? }
  
          when "Thursday"
            date_list = date_list + (start_date..end_date).select { |date| date.thursday? }
  
          when "Friday"
            date_list = date_list + (start_date..end_date).select { |date| date.friday? }
  
          when "Saturday"
            date_list = date_list + (start_date..end_date).select { |date| date.saturday? }
  
          else
            date_list = date_list + (start_date..end_date).select { |date| date.sunday? }
  
          end
  
        end
  
        return date_list
  
      end


end