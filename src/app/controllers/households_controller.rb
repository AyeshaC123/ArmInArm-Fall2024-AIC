
# Project Name: Admin Dashboard - Team 22
# Description: Allows admin to view & edit household, client, & location data
# Filename: households_controller.rb
# Description: This controller is responsible for tracking household data
#   so admin can add, edit, view, delete, search, sort, upload, & download data.
#   Also allows non-admin users to view their household data.
# Last Modified: 4/28/2024


 # Project name: Arm in Arm Project Team 12
 # Description of Project: The Arm in Arm Project aims to develop an application that assits its clients in need of food
 # Filename: households_controller.rb
 # Description: The file defines the behavior of the household webpage, with state and county dropdowns that dynamically update
 # Last modified on: April 21, 2024

# last modified on 4/24/24
# Team 13
# Added check to see if address and number of members is accurate for data being entered
# Project Arm In Arm


class HouseholdsController < ApplicationController
  #skip_before_action :authenticate_user!, only: [:new]   Why is this here?
#  before_action :set_household, only: %i[ show edit update destroy ]
  before_action :set_household, only: [:show, :edit, :update, :destroy]


  # GET /households or /households.json
  def index

    #Team 22: grabs all current locations
    @locations = Location.all

    #Team 22: stores search parameters
    input = {}
    input[:headgender] = params[:gender] if params[:gender].present?
    input[:headethnicity] = params[:ethnicity] if params[:ethnicity].present?
    input[:numadults] = params[:adults] if params[:adults].present?
    input[:numchild] = params[:children] if params[:children].present?
    input[:pantrylocation] = params[:pantryloc] if params[:pantryloc].present?
    input[:city] = params[:cityName] if params[:cityName].present?
    input[:state] = params[:stateName] if params[:stateName].present?
    input[:county] = params[:cnty] if params[:cnty].present?
    input[:zipcode] = params[:zip] if params[:zip].present?
    input[:incomesource] = params[:incomesrc] if params[:incomesrc].present?
    input[:qualifiercode] = params[:code] if params[:code].present?
    input[:householdtype] = params[:household] if params[:household].present?
    input[:foodstamps] = params[:stamps] if params[:stamps].present?
    
    #Team 22: grabs all households
    @households = Household.all

    #Team 22: Searches for specific households based on input
    if input.present?
      @households = @households.where(input)
      # Save search parameters to session
      session[:search_results] = input
    end
    
    #Team 22: Default sort order based on head of household's name
    @households = @households.order(headname: :asc) if @households.present?
    
    #Team 22: Flashes an alert if no results or notice that found results
    if @households.empty? 
      flash.now[:alert] = "No Results Found!" 
    elsif input.present? && @households.present?
      flash.now[:notice] = "Search Results Found!"
    end
    render:index
  end

  
  #Team 22: Allows user to download a copy of the current data
  def download
    #only allows admins to download
    if current_user.admin?
      @households = Household.all
      input = session[:search_results]

      #Finds households based on input
      if @households.present? && input.present?
        @households = Household.where(input)
      end

      #Creates csv file only if households found
      if @households.present?
        respond_to do |format|
          format.csv do
            send_data generate_csv(@households), filename: "households_data.csv"
          end
        end
      else
        flash.now[:alert] = "No data to download"
      end
    end
  end

    #@households = Household.where(reviewed: [nil, true])
  #end

  # Method to dynamically update the county dropdown on registration form
  def county_index
    # Get the state_name that was selected
    state_name = params[:state_name]
    # Get all counties for that state and order them alphabetically
    counties = County.where(state_name: state_name).order(:county_name)
    # Add a blank option at the beginning of the counties dropdown
    counties = [{ county_name: '', id: nil }] + counties

    render json: counties

  end

  # GET /households/1 or /households/1.json
  def show
    #Team 22: only admins can view data & user's can only view their own data
    if !current_user.admin? && @household.user_id != current_user.id
      #Only allows user to see there current information
      flash[:alert] = "You are not authorized to view this page."
      redirect_to account_index_path
    end
  end

  # GET /households/new
  def new
    #Team 22: grabs all current locations for the new household form
    @locations = Location.all
    @household = Household.new
    puts "\n\n\n @locations: #{@locations.inspect}\n\n\n"
    # This many members can be added on pre-reg form
    # 2.times { @household.members.build }
  end

  # GET /households/1/edit
  def edit
    #Team 22: comment out or below if you want users to be able to edit their household info
    if current_user.admin? #|| @household.user_id == current_user.id
      @locations = Location.all
    else
      #Team 22: Only allows admins to edit info
      flash[:alert] = "You are not authorized to view this page."
      redirect_to account_index_path
    end
  end

  # POST /households or /households.json

 #def create
 #   @household = Household.new(household_params)
 #   @household.user_id = current_user.id

   # respond_to do |format|
 #   if @household.save
   #     format.html { redirect_to household_url(@household), notice: "Household has been sent to a volunteer to review. We will contact you upon approval." }
   #     format.json { render :show, status: :created, location: @household }
    #    @household.update(reviewed: false)
  #  else
    #    format.html { render :new, status: :unprocessable_entity }
  #      format.json { render json: @household.errors, status: :unprocessable_entity }
  #  end
  #  end


  #Work on validation will be done with mostly the create file
  def create

    #Team 22: only allows admins & current users that have no household to create new households
    #if current_user.admin? || current_user.registered == false
    #  @household = Household.new(household_params)
      #Team 22: only sets user id if not an admin
     # @household.user_id = current_user.id if !current_user.admin?
      

    Rails.logger.info "Starting household creation process for user #{current_user.id}"
    if current_user.admin? || current_user.registered == false 
   # if current_user.registered == false
      @household = Household.new(household_params)
      @household.flag = false
      @household.user_id = current_user.id
  
      Rails.logger.info "Household parameters: #{@household.inspect}"
  
      if Household.exists?(headname: @household.headname, streetaddr: @household.streetaddr, zipcode: @household.zipcode)
        Rails.logger.warn "Household already exists by headname and address: #{@household.headname}, #{@household.streetaddr}, #{@household.zipcode}"
        flash.alert = "A household with this headname and address already exists."
        redirect_to root_path
        return
      end
  
      if Household.exists?(headname: @household.headname, headdob: @household.headdob)
        Rails.logger.warn "Household already exists by headname and DOB: #{@household.headname}, #{@household.headdob}"
        flash[:info] = "Warning: This headname and DOB already exists."
        @household.flag = true
      end
  
      if Household.exists?(streetaddr: @household.streetaddr, zipcode: @household.zipcode, numchild: @household.numchild, numadults: @household.numadults)
        Rails.logger.warn "Household already exists by address, number of adults and children: #{@household.streetaddr}, #{@household.zipcode}, #{@household.numadults}, #{@household.numchild}"
        flash[:info] = "Warning: This address with #{@household.numadults} adults and #{@household.numchild} children already exists."
        @household.flag = true
      end
  
      @household.streetaddr = @household.streetaddr.rstrip
  

      respond_to do |format|
        if @household.save
          Rails.logger.info "Household successfully created: #{@household.inspect}"
          format.html { redirect_to household_url(@household), notice: "Household was successfully created." }
          format.json { render :show, status: :created, location: @household }
          current_user.update(registered: true)
        else
          Rails.logger.error "Failed to create household: #{@household.errors.full_messages.join(', ')}"
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @household.errors, status: :unprocessable_entity }
        end
      end
    else
      flash.alert = "You already have a registered household."
      redirect_to root_path
    end
  end
  

        #end
      #end flag case else statement
   # end 
  

  #  else
        #redirect_to root_path
       # flash.alert = "You already have a registered household." #bootstrap
       # return
   # end
    #flash.alert = "This Household already exists." #bootstrap

  #end

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
    user_id = @household.user_id
    if @household.members.any?
      flash[:alert] = "Cannot delete household because it has associated members."
    else
      @household.destroy
      flash[:notice] = "Household was successfully destroyed."
    end

    user = User.find_by_id(user_id)
    if user
      user.update(registered: false)
    end

    respond_to do |format|
      format.html { redirect_to households_url}
      format.json { head :no_content }
    end


    # user = User.find_by(id: user_id)
    # user.update(registered: false)

  end

  #Team 22: sorts household data in ascending order based on selected sorting option
  def sort_asc
    @locations = Location.all
    #stores sorting option
    sort_by = params[:sort_by]

    #performs sort based on sorting option
    case sort_by
    when "numadults"
      @households = Household.order(numadults: :asc)
      flash.now[:notice] = "Households sorted by # of Adults in Ascending Order!"
      render 'index'
    when "numchild"
      @households = Household.order(numchild: :asc)
      flash.now[:notice] = "Households sorted by # of Children in Ascending Order!"
      render 'index'
    when "pantryloc"
      @households = Household.order(pantrylocation: :asc)
      flash.now[:notice] = "Households sorted by Pantry Location in Ascending Order!"
      render 'index'
    when "city"
      @households = Household.order(city: :asc)
      flash.now[:notice] = "Households sorted by City in Ascending Order!"
      render 'index'
    when "zip"
      @households = Household.order(zipcode: :asc)
      flash.now[:notice] = "Households sorted by Zipcode in Ascending Order!"
      render 'index'
    when "household"
      @households = Household.order(householdtype: :asc)
      flash.now[:notice] = "Households sorted by the Household Type in Ascending Order!"
      render 'index'
    when "qcode"
      @households = Household.order(qualifiercode: :asc)
      flash.now[:notice] = "Households sorted by Qualifier Code in Ascending Order!"
      render 'index'
    when "incomesrc"
      @households = Household.order(incomesource: :asc)
      flash.now[:notice] = "Households sorted by Income Source in Ascending Order!"
      render 'index'
    when "stamps"
      @households = Household.order(foodstamps: :asc)
      flash.now[:notice] = "Households sorted by Food Stamps in Ascending Order!"
      render 'index'
    when "gender"
     @households = Household.order(headgender: :asc)
     flash.now[:notice] = "Households sorted by Gender in Ascending Order!"
     render 'index'
    when "ethnicity"
     @households = Household.order(headethnicity: :asc)
     flash.now[:notice] = "Households sorted by Ethnicity in Ascending Order!"
     render 'index'
    when "county"
     @households = Household.order(county: :asc)
     flash.now[:notice] = "Households sorted by County in Ascending Order!"
     render 'index'
    else
      redirect_to households_path
      flash[:alert] = "No sorting option chosen!"
    end
  end

  # #Team 22: sorts household data in descending order based on selected sorting option
  # def sort_desc
  #   @locations = Location.all
  #   #stores sorting option
  #   sort_by = params[:sort_by]

  #   #performs sort based on sorting option
  #   case sort_by
  #   when "numadults"
  #     @households = Household.order(numadults: :desc)
  #     flash.now[:notice] = "Households sorted by # of Adults in Descending Order!"
  #     render 'index'
  #   when "numchild"
  #     @households = Household.order(numchild: :desc)
  #     flash.now[:notice] = "Households sorted by # of Children in Descending Order!"
  #     render 'index'
  #   when "pantryloc"
  #     @households = Household.order(pantrylocation: :desc)
  #     flash.now[:notice] = "Households sorted by Pantry Location in Descending Order!"
  #     render 'index'
  #   when "city"
  #     @households = Household.order(city: :desc)
  #     flash.now[:notice] = "Households sorted by City in Descending Order!"
  #     render 'index'
  #   when "zip"
  #     @households = Household.order(zipcode: :desc)
  #     flash.now[:notice] = "Households sorted by Zipcode in Descending Order!"
  #     render 'index'
  #   when "household"
  #     @households = Household.order(householdtype: :desc)
  #     flash.now[:notice] = "Households sorted by the Household Type in Descending Order!"
  #     render 'index'
  #   when "qcode"
  #     @households = Household.order(qualifiercode: :desc)
  #     flash.now[:notice] = "Households sorted by Qualifier Code in Descending Order!"
  #     render 'index'
  #   when "incomesrc"
  #     @households = Household.order(incomesource: :desc)
  #     flash.now[:notice] = "Households sorted by Income Source in Descending Order!"
  #     render 'index'
  #   when "stamps"
  #     @households = Household.order(foodstamps: :desc)
  #     flash.now[:notice] = "Households sorted by Food Stamps in Descending Order!"
  #     render 'index'
    #when "gender"
    #  @households = Household.order(headgender: :desc)
    #  flash.now[:notice] = "Households sorted by Gender in Descending Order!"
    #  render 'index'
    #when "ethnicity"
    #  @households = Household.order(headethnicity: :desc)
    #  flash.now[:notice] = "Households sorted by Ethnicity in Descending Order!"
    #  render 'index'
    #when "county"
    #  @households = Household.order(county: :desc)
    #  flash.now[:notice] = "Households sorted by County in Descending Order!"
    #  render 'index'
  #   else
  #     redirect_to households_path
  #     flash[:alert] = "No sorting option chosen!"
  #   end
  # end
# Team22: allows admin to upload a csv to update current existing households
def upload
  # checks if file is a csv file
  if params[:file].present? && params[:file].content_type == "text/csv"
    require 'csv'
    households_file = params[:file].tempfile
    update = []
    new_households = []
    error = 0
    changes = 0
    CSV.foreach(households_file, headers: true) do |row|
      household_params = row.to_hash
      household = Household.find_by(id: household_params['id'])
      if household
        if household.update(household_params)
          update << household
          changes = 1
        end
      else
        error = 1
        new_household = Household.new(household_params)
        new_households << new_household
        flash[:alert] = "Error: must manually create new households"
      end
    end

    if changes == 0 && error == 0
      flash[:alert] = "No changes needed, please edit the file to make changes before submitting!"
    elsif update.present? && error == 0
      flash[:notice] = "Households updated successfully"
    end

  else
    flash[:alert] = "Please upload a CSV file"
  end

  redirect_to households_path
end

private

def set_household
  if params[:id].present? && params[:id] != "download"
    @household = Household.find_by(id: params[:id])
    if @household.nil?
      flash[:alert] = "Household not found"
      redirect_to households_path
    end
  end
end

# def household_params
#   params.require(:household).permit(:headname, :headdob, :headgender, :headethnicity, :numadults, :numchild, :pantrylocation, :streetaddr, :city, :state, :county, :zipcode, :phonenum, :incomesource, :qualifiercode, :netincome, :householdtype, :foodstamps)
# end

 # Only allow a list of trusted parameters through.
 def household_params

  # params.require(:household).permit(:headname, :headdob, :headgender, :headethnicity, :numadults, :numchild, :pantrylocation, :streetaddr, :city, :state, :county, :zipcode, :phonenum, :incomesource, :qualifiercode, :netincome, :householdtype, :foodstamps)
  # james: added Member attributes
  params.require(:household).permit(:headname, :headdob, :headgender, :headethnicity, :numadults, :numchild, :pantrylocation, :streetaddr, :city, :state, :county, :zipcode, :phonenum, :incomesource, :qualifiercode, :netincome, :householdtype, :foodstamps,
                                    members_attributes: [:firstname, :lastname, :dob, :relationship, :household_id])

#  params.require(:household).permit(:headname, :headdob, :headgender, :headethnicity, :numadults, :numchild, :streetaddr, :city, :state, :county, :zipcode, :phonenum, :incomesource, :qualifiercode, :netincome, :householdtype, :foodstamps)

end

def generate_csv(households)
  CSV.generate(headers: true) do |csv|
    csv << Household.column_names

    households.each do |household|
      csv << household.attributes.values_at(*Household.column_names)
    end
  end
end


end
