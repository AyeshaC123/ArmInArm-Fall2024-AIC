# Project Name: Appointment Scheduler and Check-in - team 23
# Description: Add constraints to booking appointments and allow for clients to be checked into their slotted appointments
# FileName: kaminari_config.rb
# Description: the config file for gem kaminari. Presents default values which can still be altered during usage
# Last Modified: 4/22/24

# created after running "rails g kaminari:config"

# frozen_string_literal: true

Kaminari.configure do |config|
  # config.max_per_page = nil
  # config.window = 4
  # config.outer_window = 0
  # config.left = 0
  # config.right = 0
  # config.page_method_name = :page
  # config.param_name = :page
  # config.max_pages = nil
  # config.params_on_first_page = false
  config.default_per_page = 5
  config.page_method_name = :page
  config.param_name = :page
end
