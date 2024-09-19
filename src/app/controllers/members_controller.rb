class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]
  before_action :set_households, only: %i[new edit create update]

  # GET /members or /members.json
  def index
    if current_user.is_admin? # checks if user is an admin, then they can view all members of a house
      @members = Member.all
    else
      household = Household.find_by(user_id: current_user.id) # search for the household created by the user using their primary key
      @members = Member.where(household_id: household.id) # find and return a list by the household found
    end  
  end

  # GET /members/1 or /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members or /members.json
  def create
    member_name = "#{member_params[:firstname]} #{member_params[:lastname]}"
    household = find_household

    new_params = member_params.to_h

    if household
      new_params[:household_id] = household.id
      if household.headname.casecmp?(member_name)
        redirect_to new_member_path
        flash.alert = "A household with this address and head of house hold already exists"
        return
      end
    end

    @member = Member.new(new_params)
    respond_to do |format|
      if @member.save
        format.html { redirect_to member_url(@member), notice: "Member was successfully created." }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1 or /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to member_url(@member), notice: "Member was successfully updated." }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1 or /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: "Member was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def set_households
    @households = Household.all.pluck(:headname, :streetaddr, :id) if current_user.admin?
  end

  def find_household
    if current_user.is_admin?
      Household.find_by(id: params[:member][:household_id])
    else
      street_address = params[:member][:household_id].rstrip
      Household.find_by(streetaddr: street_address, user_id: current_user.id)
    end
  end

  def member_params
    params.require(:member).permit(:firstname, :lastname, :dob, :relationship, :household_id)
  end
end
