# frozen_string_literal: true

# Represents a user of the web application
class User < ApplicationRecord
  # Devise is a premade system for managing logins
  # You don't need to do login yourself. It's done for you.
  # TCNJ: don't edit the login system.

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: {
    # Client role is for those using Arm in Arm.
    client: 0,
    # Admin role is for volunteers and members of Arm in Arm.
    admin: 1,
  }

  belongs_to :client, dependent: :destroy, optional: true

  # Helper method to check if the user is a client.
  def is_client?
    role == 'client'
  end

  # Helper method to check if the user is an admin.
  def is_admin?
    role == 'admin'
  end

  # Returns true if the user should own a client profile.
  def can_have_client_profile?
    # Only client can have profile.
    is_client?
  end

  # Returns true if the user should create a client profile for themselves.
  def needs_client_profile?
    # Only if the user is a client and doesn't have a profile.
    can_have_client_profile? and client.nil?
  end

  # Returns true if the user can create client profiles for others.
  def can_create_other_client_profiles?
    # Admins can do this.
    is_admin?
  end

  # Returns true if the user can create a client profile in their current state.
  def can_create_client_profile?
    needs_client_profile? or can_create_other_client_profiles?
  end

  # Returns true if the user can use the search feature.
  def can_search?
    # Admins can search.
    is_admin?
  end
end
