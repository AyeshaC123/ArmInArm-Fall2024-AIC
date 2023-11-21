class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :date_of_appt
      t.datetime :time_of_appt
      t.string :location

      t.timestamps
    end
  end
end
