# frozen_string_literal: true

# This is the main controller for the entire project
# Every other controller will inherit from this one
# If there is a behavior or method you want for all controllers,
# it goes here. If that method is a helper, don't add it here,
# but in the helpers folder. They will be avalable in their
# respected views.
class ApplicationController < ActionController::Base
  # If someone tried to pretend to be someone else, an error occurs for them
  protect_from_forgery with: :exception
  # See if the current user is logged in
  before_action :authenticate_user!
  # See if the current user has a client profile
  before_action :require_profile

  def require_profile
    # Redirect user to client creation page if:
    #   the user is logged in,
    #   the user is not visiting the /clients page (creating a client),
    #   the user is not visiting the /new_client page (avoid infinite redirect), and
    #   the user does not have a client associated with their account.
    if not current_user.nil? and request.path != '/clients' and request.path != '/new_client' and current_user.client.nil?
      redirect_to '/new_client'
    end
  end
end
