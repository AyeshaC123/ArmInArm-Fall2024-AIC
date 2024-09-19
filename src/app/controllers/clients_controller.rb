# Project Name: Admin Dashboard - Team 22
# Description: Allows admin to view & edit household, client, & location data
# Filename: households_controller.rb
# Description: This controller is responsible for tracking client data
#   so admin can add, edit, view, delete, & sort data.
#   Also allows non-admin users to view their client data.
# Last Modified: 4/28/2024

class ClientsController < ApplicationController
  #Team22: retrieves & displays clients information
  # GET /clients
  def index
    #grabs all client data
    @clients = Client.all 

    #sorts data by the client's first name in ascending order
    @clients = @clients.order(first_name: :asc) if @client.present?
  end
  
  #Creates new instance of client
  # GET /households/new
  def new
    @client = Client.new
  end

  #Gets client data to be editted
  #Gets /households/1/edit
  def edit
    @client = Client.find(params[:id])
    #shows only for admin or current user
    #if current_user.admin? || @client.id == current_user.id
    #  render :client
    #else
    #  flash[:alert] = "You are not authorized to view this page : user id = #{current_user.id}, client_id = #{@client.id}."
    #  redirect_to account_index_path
    #end
  end

  #Updates client data based on edit form
  # PUT /households/1
  def update
    @client = Client.find(params[:id])
    
    # Handle unchecked allergy parameters
    allergy_params = params.permit(*Client::COMMON_ALLERGENS.map(&:first))
    Client::COMMON_ALLERGENS.each do |allergen, _|
      allergy_params[allergen] = false unless allergy_params.has_key?(allergen)
    end

    # Update client with combined parameters
    if @client.update(allergy_params.merge(client_params))
      logger.debug @client.inspect
      flash[:notice] = "Client profile updated successfully!"
      redirect_to client_path(@client)
    else
      flash.now[:alert] = "Failed to update client profile."
      render :edit
    end
  end

  #Deletes a specific client
  #DELETE /households/1
  def destroy
    @client = Client.find(params[:id])
    User.where(client: @client).each do |user|
      user.client = nil 
      user.save
    end
    if @client.destroy
      flash[:notice] = "Client profile was successfully deleted."
    else
      @client.errors.full_messages
      flash[:alert] = "There was a problem deleting the client profile."
    end
    redirect_to root_path # or wherever you want to redirect after deletion
  end

  #Creates a new client from new form
  # POST /households
  def create
    # Forbid creating a profile if not allowed.
    if not current_user.can_create_client_profile? 
      flash.now[:alert] = "Not allowed to create client profile."
      render :new
    else
      cparams = client_params
      # cparams[:dob] = Date.strptime(cparams[:dob], '%m/%d/%Y')
      @client = Client.new(cparams)
      if @client.save
        if current_user.needs_client_profile?
          current_user.client = @client
          current_user.save
        end
        flash[:notice] = "Client profile created successfully!"
        redirect_to client_path(@client)  # Redirect to the show action
      else
        flash.now[:alert] = "Failed to create client profile."
        render :new
      end
    end
  end
  
  #Displays client data
  # GET /households/1
  def show
    @client = Client.find(params[:id])
    render :client
    #shows only for admin or current user
    #if current_user.admin? || @client.id == current_user.id
    #  render :client
    #else
    #  flash[:alert] = "You are not authorized to view this page : user id = #{current_user.id}, client_id = #{@client.id}."
    #  redirect_to account_index_path
    #end
  end

  #Team 22: sorts client data in ascending order based on selected sorting option
  def sort_asc
    #stores sorting option
    sort_by = params[:sort_by]

    #performs sort based on sorting option
    case sort_by
    when "lang"
      @clients = Client.order(language: :asc)
      flash.now[:notice] = "Clients sorted by Languages in Ascending Order!"
      render 'index'
    when "religion"
      @clients = Client.order(religion: :asc)
      flash.now[:notice] = "Clients sorted by Religions in Ascending Order!"
      render 'index'
    when "peanuts"
      @clients = Client.order(allergy_peanuts: :asc)
      flash.now[:notice] = "Clients sorted by Peanut Allergy in Ascending Order!"
      render 'index'
    when "treenuts"
      @clients = Client.order(allergy_treenuts: :asc)
      flash.now[:notice] = "Clients sorted by Treenut Allergy in Ascending Order!"
      render 'index'
    when "eggs"
      @clients = Client.order(allergy_eggs: :asc)
      flash.now[:notice] = "Clients sorted by Egg Allergy in Ascending Order!"
      render 'index'
    when "milk"
      @clients = Client.order(allergy_milk: :asc)
      flash.now[:notice] = "Clients sorted by Milk Allergy in Ascending Order!"
      render 'index'
    when "shellfish"
      @clients = Client.order(allergy_shellfish: :asc)
      flash.now[:notice] = "Clients sorted by Shellfish Allergy in Ascending Order!"
      render 'index'
    when "fish"
      @clients = Client.order(allergy_fish: :asc)
      flash.now[:notice] = "Clients sorted by Fish Allergy in Ascending Order!"
      render 'index'
    when "wheat"
      @clients = Client.order(allergy_wheat: :asc)
      flash.now[:notice] = "Clients sorted by Wheat Allergy in Ascending Order!"
      render 'index'
    when "soy"
      @clients = Client.order(allergy_soy: :asc)
      flash.now[:notice] = "Clients sorted by Soy Allergy in Ascending Order!"
      render 'index'
    when "gluten"
      @clients = Client.order(gluten_free: :asc)
      flash.now[:notice] = "Clients sorted by if clients need Gluten Free in Ascending Order!"
      render 'index'
    when "vegan"
      @clients = Client.order(vegan: :asc)
      flash.now[:notice] = "Clients sorted by if clietns are Vegan in Ascending Order!"
      render 'index'
    when "diet"
      @clients = Client.order(restrictions: :asc)
      flash.now[:notice] = "Clients sorted by the Dietary Restrictions in Ascending Order!"
      render 'index'
    else
      redirect_to clients_path
      flash[:alert] = "No sorting option chosen!"
    end
  end

  #Team 22: sorts client data in descending order based on selected sorting option
  def sort_desc
    #stores sorting option
    sort_by = params[:sort_by]

    #performs sort based on sorting option
    case sort_by
    when "lang"
      @clients = Client.order(language: :desc)
      flash.now[:notice] = "Clients sorted by Languages in Descending Order!"
      render 'index'
    when "religion"
      @clients = Client.order(religion: :desc)
      flash.now[:notice] = "Clients sorted by Religions in Descending Order!"
      render 'index'
    when "peanuts"
      @clients = Client.order(allergy_peanuts: :desc)
      flash.now[:notice] = "Clients sorted by Peanut Allergy in Descending Order!"
      render 'index'
    when "treenuts"
      @clients = Client.order(allergy_treenuts: :desc)
      flash.now[:notice] = "Clients sorted by Treenut Allergy in Descending Order!"
      render 'index'
    when "eggs"
      @clients = Client.order(allergy_eggs: :desc)
      flash.now[:notice] = "Clients sorted by Egg Allergy in Descending Order!"
      render 'index'
    when "milk"
      @clients = Client.order(allergy_milk: :desc)
      flash.now[:notice] = "Clients sorted by Milk Allergy in Descending Order!"
      render 'index'
    when "shellfish"
      @clients = Client.order(allergy_shellfish: :desc)
      flash.now[:notice] = "Clients sorted by Shellfish Allergy in Descending Order!"
      render 'index'
    when "fish"
      @clients = Client.order(allergy_fish: :desc)
      flash.now[:notice] = "Clients sorted by Fish Allergy in Descending Order!"
      render 'index'
    when "wheat"
      @clients = Client.order(allergy_wheat: :desc)
      flash.now[:notice] = "Clients sorted by Wheat Allergy in Descending Order!"
      render 'index'
    when "soy"
      @clients = Client.order(allergy_soy: :desc)
      flash.now[:notice] = "Clients sorted by Soy Allergy in Descending Order!"
      render 'index'
    when "gluten"
      @clients = Client.order(gluten_free: :desc)
      flash.now[:notice] = "Clients sorted by if clients need Gluten Free in Descending Order!"
      render 'index'
    when "vegan"
      @clients = Client.order(vegan: :desc)
      flash.now[:notice] = "Clients sorted by if clietns are Vegan in Descending Order!"
      render 'index'
    when "diet"
      @clients = Client.order(restrictions: :desc)
      flash.now[:notice] = "Clients sorted by the Dietary Restrictions in Descending Order!"
      render 'index'
    else
      redirect_to clients_path
      flash[:alert] = "No sorting option chosen!"
    end
  end

  private

  def client_params
    params.require(:first_name)
    params.require(:last_name)
    params.require(:dob)
    params.permit(
        :first_name,
        :last_name,
        :dob,
        :address,
        :language,
        :religion,
        :gluten_free,
        :vegan,
        :restrictions,
        # Permits all common allergen parameters
        *Client::COMMON_ALLERGENS.map(&:first),
      )
  end
  
end
