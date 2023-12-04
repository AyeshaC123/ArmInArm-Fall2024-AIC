class NewClientController < ApplicationController
  before_action :check_permission

  # User should have permission to visit this page.
  def check_permission
    # Deny access if the user has a client profile and cannot make other profiles
    if current_user.nil? or not current_user.can_create_client_profile?
      redirect_to root_path
    end
  end
end
