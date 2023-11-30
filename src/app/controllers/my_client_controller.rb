class MyClientController < ApplicationController
  def index
    client = current_user.client
    if client.nil?
      # User has no client, send to new client page.
      # This shouldn't happen due to another redirect, but best to be safe.
      redirect_to '/new_client'
    else
      # Send to the client path to allow modifying or deleting.
      redirect_to client_path(client)
    end
  end
end
