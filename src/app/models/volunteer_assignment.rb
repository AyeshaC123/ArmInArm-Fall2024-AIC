# app/models/volunteer_assignment.rb
class VolunteerAssignment < ApplicationRecord
    belongs_to :volunteer
    belongs_to :role
    belongs_to :time_slot
end
  