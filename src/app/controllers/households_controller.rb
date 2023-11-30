class HouseholdsController < ApplicationController
  before_action :set_household, only: %i[ show edit update destroy ]

  # GET /households or /households.json
  def index
    @households = Household.all
  end

  # GET /households/1 or /households/1.json
  def show
  end

  # GET /households/new
  def new
    @household = Household.new
  end

  # GET /households/1/edit
  def edit
  end

  # POST /households or /households.json
  def create
    

    if current_user.registered == false
      @household = Household.new(household_params)
      @household.user_id = current_user.id

      respond_to do |format|
        if @household.save
          format.html { redirect_to household_url(@household), notice: "Household was successfully created." }
          format.json { render :show, status: :created, location: @household }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @household.errors, status: :unprocessable_entity }
        end
      end
      current_user.update(registered: true)

    else
        redirect_to root_path
        flash.alert = "You already have a registered household."

    end
  end

  # PATCH/PUT /households/1 or /households/1.json
  def update
    respond_to do |format|
      if @household.update(household_params)
        format.html { redirect_to household_url(@household), notice: "Household was successfully updated." }
        format.json { render :show, status: :ok, location: @household }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @household.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /households/1 or /households/1.json
  def destroy
    @household.destroy

    user_id = @household.user_id

    respond_to do |format|
      format.html { redirect_to households_url, notice: "Household was successfully destroyed." }
      format.json { head :no_content }
    end

    user = User.find_by_id(id: user_id)
    user.update(registered: false)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_household
      @household = Household.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def household_params
      params.require(:household).permit(:headname, :headdob, :headgender, :headethnicity, :numadults, :numchild, :streetaddr, :city, :state, :county, :zipcode, :phonenum, :incomesource, :qualifiercode, :netincome, :householdtype, :foodstamps)
    end
end
