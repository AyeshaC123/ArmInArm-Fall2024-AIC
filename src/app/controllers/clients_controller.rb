class ClientsController < ApplicationController
  def new
    @client = Client.new
  end

  

  def edit
    @client = Client.find(params[:id])
  end

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

  
  
  


  def create
    # Forbid creating a profile if not allowed.
    if not current_user.can_create_client_profile? 
      flash.now[:alert] = "Not allowed to create client profile."
      render :new
    else
      cparams = client_params
      puts cparams
      cparams[:dob] = Date.strptime(cparams[:dob], '%m/%d/%Y')
      puts cparams
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
  
  def show
    @client = Client.find(params[:id])
    render :client
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
