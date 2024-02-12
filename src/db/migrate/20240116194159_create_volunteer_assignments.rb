class CreateVolunteerAssignments < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteer_assignments do |t|
      t.integer :volunteer_id
      t.integer :role_id
      t.integer :time_slot_id
    end
  end
end
