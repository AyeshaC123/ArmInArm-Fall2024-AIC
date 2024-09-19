# Project name: Arm in Arm Appointment Booker - Team 14 / 21 / ( 23 from Spr 2024 )
# Description: Allows clients to create/view/delete appointments and admin to manage existing appointments
# Filename: admin_panel_controller.rb
# Description: Controller for the admin panel that interacts with the view for the panel to make changes made by teams 14 and 21.
#              I am concerned with the fact that any user can access this resource. One example is by simple going to the URL for the panels page.


# Last modified on: 04/19/2024



class AdminPanelsController < ApplicationController
  before_action :set_admin_panel, only: %i[ show edit update ]

  before_action :check_authority, only: %i[ de_activate_event activate_event index new show edit update destroy create ]

  # GET /admin_panels or /admin_panels.json
  def index
    @admin_panels = AdminPanel.all

    @temp_active_array = @admin_panels.where( event_active: true )
    @temp_de_active_array = @admin_panels.where( event_active: false )

    
  end

  # GET /admin_panels/1 or /admin_panels/1.json
  def show
  end

  # GET /admin_panels/new
  def new
    @admin_panel = AdminPanel.new
  end

  # GET /admin_panels/1/edit
  def edit
  end

  # POST /admin_panels or /admin_panels.json
  def create

    @admin_panel = AdminPanel.new(admin_panel_params)

    # the date formats that I send in are not usually accepted right away
    @admin_panel.update( start_date: params[ :admin_panel ][ :start_date ].to_date( ), end_date: params[ :admin_panel ][ :end_date ].to_date( ), 
                         event_title: params[ :admin_panel ][ :event_title ], location: params[ :admin_panel ][ :location ],
                          check_in_grace_period: params[ :admin_panel ][ :check_in_grace_period ] )


    respond_to do |format|
      if @admin_panel.save
        
        format.html { redirect_to admin_panels_path, notice: "Admin panel was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_panels/1 or /admin_panels/1.json
  def update

    # the date formats that I send in are not usually accepted right away
    @admin_panel.update( start_date: params[ :admin_panel ][ :start_date ].to_date( ), end_date: params[ :admin_panel ][ :end_date ].to_date( ), 
                         event_title: params[ :admin_panel ][ :event_title ], location: params[ :admin_panel ][ :location ],
                         check_in_grace_period: params[ :admin_panel ][ :check_in_grace_period ] )


    respond_to do |format|
      if @admin_panel.update(admin_panel_params)
        format.html { redirect_to admin_panels_path, notice: "Admin panel was successfully updated."}
        format.json { render :show, status: :ok, location: @admin_panel }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_panel.errors, status: :unprocessable_entity }
      end
    end

    

  end

  # DELETE /admin_panels/1 or /admin_panels/1.json
  def destroy

    # this is gonna be a number value
    the_event_id = params[:event_id]

    # this is for when an event is being removed
    Appointment.where( admin_panels_id: the_event_id ).each do | appointment |

      appointment.destroy( )

    end

    AdminPanel.all.find_by( id: the_event_id ).destroy( )

    # returning to the main admin panels page
    redirect_to main_event_page_path

    
  end


  def activate_event(  )
    # this will get am event to activate

    event = AdminPanel.where( id: (params[:event]) )
    event.update( event_active: true )

    flash[:msg] = 'Event #{ event.event_title } has been Activated'

    # returning to the main admin panels page
    redirect_to main_event_page_path

  end


  def de_activate_event(  )

    # this is to deactivate an event found in the admin panel
    event = AdminPanel.where( id: (params[:event]) )
    event.update( event_active: false )

    flash[:msg] = 'Event #{ event.event_title } has been De-activated'

    # returning to the main admin panels page
    redirect_to main_event_page_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_panel
      @admin_panel = AdminPanel.find(params[:id])
    end

    def check_authority

      if ( current_user.admin == 0)
        # regular users do not have access to the Admins panenl
        redirect_to root_path
      end

    end

    # Only allow a list of trusted parameters through.
    def admin_panel_params
      params.require(:admin_panel).permit(:appointment_length, :max_appointment_count, :start_time, :end_time,:check_in_grace_period, booking_days: [])
    end
end