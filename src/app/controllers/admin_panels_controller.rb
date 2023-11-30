class AdminPanelsController < ApplicationController
  before_action :set_admin_panel, only: %i[ show edit update destroy ]

  # GET /admin_panels or /admin_panels.json
  def index
    @admin_panels = AdminPanel.all
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

    respond_to do |format|
      if @admin_panel.save
        
        # format.html { redirect_to admin_panel_url(@admin_panel), notice: "Admin panel was successfully created." }
        format.html { redirect_to admin_panels_path, notice: "Admin panel was successfully created." }
        format.json { render :show, status: :created, location: @admin_panel }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_panels/1 or /admin_panels/1.json
  def update
    respond_to do |format|
      if @admin_panel.update(admin_panel_params)
        # format.html { redirect_to admin_panel_url(@admin_panel), notice: "Admin panel was successfully updated." }
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
    @admin_panel.destroy

    respond_to do |format|
      format.html { redirect_to admin_panels_url, notice: "Admin panel was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_panel
      @admin_panel = AdminPanel.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    
    # def admin_panel_params
    #   params.require(:admin_panel).permit(:appointment_length, :max_appointment_count, :booking_days, :service_time)

    # end

    def admin_panel_params
      params.require(:admin_panel).permit(:appointment_length, :max_appointment_count, :service_time, :start_time, :end_time, booking_days: [])
    end
end
