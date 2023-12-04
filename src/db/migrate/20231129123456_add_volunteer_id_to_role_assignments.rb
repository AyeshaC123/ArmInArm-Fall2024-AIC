class AddVolunteerIdToRoleAssignments < ActiveRecord::Migration[6.0]
    def change
      add_column :role_assignments, :volunteer_id, :integer
      add_index :role_assignments, :volunteer_id
    end
  end
  