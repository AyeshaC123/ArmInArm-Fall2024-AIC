class RoleAssignment < ApplicationRecord
    belongs_to :volunteer
    belongs_to :role
end
