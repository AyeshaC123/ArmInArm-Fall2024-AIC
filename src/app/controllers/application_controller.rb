# frozen_string_literal: true

# This is the main controller for the entire project
# Every other controller will inherit from this one
# If there is a behavior or method you want for all controllers,
# it goes here. If that method is a helper, don't add it here,
# but in the helpers folder. They will be avalable in their
# respected views.
class ApplicationController < ActionController::Base

  include ApplicationHelper

  # If someone tried to pretend to be someone else, an error occurs for them
  protect_from_forgery with: :exception
  # See if the current user is logged in
  before_action :authenticate_user!
  # See if the current user has a client profile
  before_action :require_profile

  # Switch locale for requests
  around_action :switch_locale

  def toggle_colorblind
    session[:colorblind] = session[:colorblind] == "enabled" ? "disabled" : "enabled"
    redirect_back(fallback_location: root_path)
  end
  
  def toggle_dyslexic_font
    session[:dyslexic_font] = session[:dyslexic_font] == 'enabled' ? nil : 'enabled'
    redirect_back(fallback_location: root_path)
  end

  def require_profile
    # Redirect user to client creation page if:
    #   the user is logged in,
    #   the user is not visiting the /clients page (creating a client),
    #   the user is not visiting the /new_client page (avoid infinite redirect), and
    #   the user needs a client profile associated with their account.
    if not current_user.nil? and request.path != '/clients' and request.path != '/new_client' and request.path != '/users/sign_out' and current_user.needs_client_profile?
      redirect_to '/new_client'
    end
  end

  def switch_locale(&action)
    if not current_user.nil?
      if params.has_key? :locale
        current_user.locale = params[:locale]
        current_user.save
        params.delete :locale
        redirect_to request.path, **params.to_unsafe_h
      else
        if I18n.available_locales.map(&:to_s).include? current_user.locale
          I18n.with_locale(current_user.locale, &action)
        else
          I18n.with_locale(I18n.default_locale, &action)
        end
      end
    else
      I18n.with_locale(I18n.default_locale, &action)
    end
  end
end
