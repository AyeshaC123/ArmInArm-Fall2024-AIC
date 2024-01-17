class AddIndexToRoleAssignments < ActiveRecord::Migration[6.0]
  def change
    add_index :role_assignments, :volunteer_id
  end
end
