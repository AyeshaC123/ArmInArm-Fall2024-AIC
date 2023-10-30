class ClientsController < ApplicationController
    def new
      @client = Client.new
    end
  
    def create
      cparams = client_params
      puts cparams
      cparams[:dob] = Date.strptime(cparams[:dob], '%m/%d/%Y')
      puts cparams
      @client = Client.new(cparams)
      if @client.save
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
          :allergies,
          :restrictions
        )
    end
  end
  
