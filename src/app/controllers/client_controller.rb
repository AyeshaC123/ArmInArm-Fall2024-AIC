class ClientsController < ApplicationController
    def new
      @client = Client.new
    end
  
    def create
      @client = Client.new(client_params)
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
    end
    
  
    private
  
    def client_params
      params.require(:client).permit(
        :first_name, 
        :last_name, 
        :dob, 
        :age, 
        :address, 
        :language, 
        :religion, 
        :allergies, 
        :restrictions
      )
    end
  end
  