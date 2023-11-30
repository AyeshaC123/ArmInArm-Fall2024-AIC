# frozen_string_literal: true

# Controller for the home page already made for you
class AccountController < ApplicationController
  before_action :load_users, only: [:index]

  def index
    user_id = current_user.id
    user_household = Household.find_by_user_id
    @qr_code_url = generate_qr_code_url(user_household.id)
    @qr_code = generate_qr_code(@qr_code_url) # placeholder, replace with url
  end

  def generate_qr_code_url(household_id)
    "http://csc415-team22.hpc.tcnj.edu:3000/households/#{household_id}"
  end

  def generate_qr_code(url)
    qrcode = RQRCode::QRCode.new(url)
    # You can customize the size and other options
    qrcode.as_svg(module_size: 3).html_safe
  end

  def load_users
    @user = User.all
  end
end