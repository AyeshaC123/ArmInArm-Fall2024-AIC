class CreateRoleAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :role_assignments do |t|
      t.integer :role_id
      t.integer :time_slot_id
      t.integer :people_count
      t.integer :volunteer_id
    end
  end
end
