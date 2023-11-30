class Role < ApplicationRecord
    validates :max_capacity, presence: true

  # Example: retrieve roles available on the selected day
  def self.available_roles(selected_day)
    where(day: selected_day).where('capacity < ?', 3)
  end

  # Example: filter roles based on volunteer interests
  def self.filter_by_interests(roles, volunteer_interests)
    roles.select { |role| (role.interests & volunteer_interests).any? }
  end

  # Example: assign volunteer to one of the filtered roles
  def self.assign_volunteer(filtered_roles, volunteer_interests)
    # Prioritize "Interaction and Language Communication" role
    interaction_role = filtered_roles.find { |role| role.name == 'Client Interaction and Sign In' }

    return interaction_role if volunteer_interests.include?('Interpersonal Interaction & Language Communication') && interaction_role

    # Randomly assign the volunteer to one of the filtered roles
    filtered_roles.sample
  end

  # Check if the role has available capacity
  def available_capacity?
    capacity < 3
  end

  # Increment the role's capacity
  def increment_capacity
    increment!(:capacity)
  end
end