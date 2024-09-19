# frozen_string_literal: true

# Helper functions made here are accessable in all views
# for example, app_name is now accessable to all views
module ApplicationHelper
  # check is user is registered, return true/false
  def check_registered_or_admin()

    puts(" HOOOO")
    puts(" HOOOO")
    puts(" HOOOO")
    puts(" HOOOO")

    # if no one is logged in, return nothing
    if !current_user.present?
      return
    end



    # is registered or admin then return true, false otherwise
    if (current_user.registered) and (current_user.admin == 0)
      return false

    else
      return true
    end


  end

  def check_admin()

    if current_user.present?


      if current_user.admin == 1
        return true
      end
    end
  end



  def app_name
    conf = app_config
    if conf.nil?
      '?'
    else
      conf.name
    end
  end

  private

  def app_config
    AppConfig.first
  end

  # Team 14: Method to fetch a translation, given the key and the user's current selected language
  def get_translation(key)
    Translation.where("key = ?", key)[0][current_user&.locale]
  end
end
