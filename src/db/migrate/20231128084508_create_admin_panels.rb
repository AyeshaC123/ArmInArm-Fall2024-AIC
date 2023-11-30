class CreateAdminPanels < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_panels do |t|
      t.integer :appointment_length
      t.integer :max_appointment_count
      t.string :booking_days
      t.integer :service_time

      t.timestamps
    end
  end
end
