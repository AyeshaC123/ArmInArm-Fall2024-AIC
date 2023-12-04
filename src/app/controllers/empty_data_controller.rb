class EmptyDataController < ApplicationController
  def clear_database
    # Reset people_count to 0 for all role_assignment records
    RoleAssignment.update_all(people_count: 0)

    # Delete all VolunteerAssignment and Volunteer records
    VolunteerAssignment.delete_all
    Volunteer.delete_all

    # Redirect with a notice
    redirect_to root_path, notice: 'Database has been cleared.'
  end
end
