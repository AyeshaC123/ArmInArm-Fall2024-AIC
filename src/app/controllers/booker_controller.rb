class BookerController < ApplicationController
    def new
      @client = Client.new
    end
    
    def show
      @client = Client.find(params[:id])
      render :booker
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
  
