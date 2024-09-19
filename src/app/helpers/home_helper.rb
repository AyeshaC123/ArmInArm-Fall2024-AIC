# frozen_string_literal: true

# Helper methods accessable for views within the home folder
module HomeHelper

    # check is user is registered, return true/false
  def check_registered_or_admin()

    # if no one is logged in, return nothing
    if !current_user.present?
      return
    end



    # is registered or admin then return true, false otherwise
    if (current_user.registered) or (current_user.admin == 1)

      return true

    else
      return false
    end


  end

  def check_registered( )
    # if no one is logged in, return nothing
    if !current_user.present?
      return
    end



    # is registered then return true, false otherwise
    if (current_user.registered)

      return true

    end

    return false

  end


  def check_admin( )
    # if no one is logged in, return nothing
    if !current_user.present?
      return
    end



    # is admin then return true, false otherwise
    if (current_user.admin == 1)

      return true

    end

    return false

  end


end







