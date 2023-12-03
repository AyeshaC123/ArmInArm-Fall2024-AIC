class Volunteer < ApplicationRecord
  has_many :volunteer_assignments
  has_many :role_assignments
  has_many :roles, through: :role_assignments

  # Define a mapping of interests to roles
  INTEREST_ROLE_MAP = {
    "Interpersonal Interaction and Language Communication" => ["Client Interaction and Sign In"],
    "Logistics & Organization" => ["Inventory Management and Restocking"],
    "Health & Nutrition" => ["Food Sorting"],
    "Resource Management" => ["Food Packing"],
    "Maintenance" => ["Pantry Cleanup"]
  }

  # Define the method to schedule a volunteer
  def schedule_volunteer
    Rails.logger.info "Scheduling volunteer: #{self.id}"
    selected_interests = JSON.parse(self.interests) rescue []
    selected_day = self.day
  
    # Initialize potential roles based on interests
    potential_roles = selected_interests.flat_map { |interest| INTEREST_ROLE_MAP[interest] }.uniq
  
    # Check for primary interest role availability
    primary_interest = "Interpersonal Interaction and Language Communication"
    if selected_interests.include?(primary_interest)
      primary_roles = INTEREST_ROLE_MAP[primary_interest]
      primary_role_assigned = primary_roles.any? { |role| assign_role_if_available(role, selected_day) }
      
      return if primary_role_assigned
    end
  
    # Check other interest roles if primary is not available or not selected
    other_roles = potential_roles - INTEREST_ROLE_MAP[primary_interest]
    other_role_assigned = other_roles.any? { |role| assign_role_if_available(role, selected_day) }
  
    # Assign a random role if no preferred role is available
    assign_random_role(selected_day) unless other_role_assigned
  end
  
  
  

  private

  def assign_role_if_available(role_name, day)
    if role_available?(role_name, day)
      assign_role([role_name], day)
      true
    else
      false
    end
  end

  def assign_random_role(day)
    all_roles = Role.pluck(:role_name)
    open_roles = all_roles.select { |role| role_available?(role, day) }
    if open_roles.any?
      random_role = open_roles.sample
      Rails.logger.info "Randomly assigning to an open role: #{random_role}"
      assign_role([random_role], day)
    else
      Rails.logger.info "No open roles available. Please try volunteering next week."
    end
  end

  def role_available?(*role_names, day)
    # Check if there is availability in the given roles for the selected day
    role_ids = Role.where(role_name: role_names).pluck(:id)
    RoleAssignment.where(role_id: role_ids, time_slot_id: TimeSlot.find_by(day_of_week: day).id, people_count: 0..2).exists?
  end

  def find_least_assigned_role(role_names, day)
    Rails.logger.info "Finding least assigned role for: #{role_names} on day: #{day}"
    role_ids = Role.where(role_name: role_names).pluck(:id)
    Rails.logger.info "Role IDs found: #{role_ids}"
  
    time_slot = TimeSlot.find_by(day_of_week: day)
    return nil if time_slot.nil?

    #Rails.logger.info "Time Slot ID: #{time_slot.id}"
  
  # Modified query
  least_assigned_role_id = RoleAssignment.where(role_id: role_ids, time_slot_id: time_slot.id)
                                         .group(:role_id)
                                         .order('COUNT(*) ASC')
                                         .limit(1)
                                         .pluck(:role_id)
                                         .first

  if least_assigned_role_id
    least_assigned_role = Role.find_by(id: least_assigned_role_id)
    Rails.logger.info "Least assigned role found: #{least_assigned_role.role_name}"
    least_assigned_role
  else
    Rails.logger.info "No least assigned role found"
    nil
  end
rescue => e
  Rails.logger.error "Error in find_least_assigned_role: #{e.message}"
  nil
end
  

  def assign_role(role_names, day)
    Rails.logger.info "Attempting to assign role from: #{role_names} on day: #{day}"
    time_slot_id = TimeSlot.find_by(day_of_week: day)&.id
  
    if time_slot_id.nil?
      Rails.logger.error "No time slot found for day: #{day}"
      return
    end
  
    #role_ids = Role.where(role_name: role_names).pluck(:id)
    role_ids = if role_names.first.is_a?(Role)
                role_names.map(&:id)
              else
                Role.where(role_name: role_names).pluck(:id)
              end
              
    role_ids.each do |role_id|
      role_assignment = RoleAssignment.find_by(role_id: role_id, time_slot_id: time_slot_id)
  
      if role_assignment && role_assignment.people_count < 3
        role_assignment.increment!(:people_count)
        begin
          VolunteerAssignment.create!(volunteer_id: self.id, role_id: role_id, time_slot_id: time_slot_id)
          Rails.logger.info "Assigned Volunteer ID #{self.id} to Role ID #{role_id} in Time Slot ID #{time_slot_id}"
          break
        rescue => e
          Rails.logger.error "Failed to create VolunteerAssignment: #{e.message}"
        end
      else
        Rails.logger.info "Role ID #{role_id} in Time Slot ID #{time_slot_id} is full or not found"
      end
    end
  end
  
  
end
 