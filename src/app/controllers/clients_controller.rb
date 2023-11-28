class ClientsController < ApplicationController
    def new
      @client = Client.new
    end

    

    def edit
      @client = Client.find(params[:id])
    end

    def update
      @client = Client.find(params[:id])
      if @client.update(client_params)
        flash[:notice] = "Client profile updated successfully!"
        redirect_to client_path(@client)
      else
        flash.now[:alert] = "Failed to update client profile."
        render :edit
      end
    end

    
    
    

  
    def create
      cparams = client_params
      puts cparams
      cparams[:dob] = Date.strptime(cparams[:dob], '%m/%d/%Y')
      puts cparams
      @client = Client.new(cparams)
      if @client.save
        current_user.client = @client
        current_user.save
        flash[:notice] = "Client profile created successfully!"
        redirect_to client_path(@client)  # Redirect to the show action
      else
        flash.now[:alert] = "Failed to create client profile."
        render :new
      end
    end
    
    def show
      @client = Client.find(params[:id])
      render :client
    end
    
  
    private
  
    def client_params
      params.require(:client).permit(
        :first_name,
        :last_name,
        :dob,
        :address,
        :language,
        :religion,
        :gluten_free,
        :vegan,
        :restrictions,
        *Client::COMMON_ALLERGENS.map(&:first),
      )
    end
    
  end
  
