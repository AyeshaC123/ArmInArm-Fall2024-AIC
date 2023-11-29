# frozen_string_literal: true

# Controller for the home page already made for you
class AccountController < ApplicationController
  before_action :load_users, only: [:index]

  def index
    @user = current_user
    # @household = @user.household
    # @qr_code_url = generate_qr_code_url(@user.id)
    @qr_code = generate_qr_code("http://csc415-team22.hpc.tcnj.edu:3000/households/1") # placeholder, replace with url
  end

  def generate_qr_code_url(user_id)
    "http://csc415-team22.hpc.tcnj.edu:3000/households/#{user_id}"
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