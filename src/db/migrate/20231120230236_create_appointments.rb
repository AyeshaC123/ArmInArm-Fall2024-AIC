class CreateAppointments < ActiveRecord::Migration[6.0]
  # def change
  #   create_table :appointments do |t|
  #     t.references :client, null: false, foreign_key: true
  #     t.datetime :date_of_appt
  #     t.datetime :time_of_appt
  #     t.string :location

  #     t.timestamps
  #   end
  # end
  def change
    create_table :appointments do |t|
      t.bigint :client_id, null: false
      t.datetime :date_of_appt
      t.datetime :time_of_appt
      t.string :location
      t.string :last_name
      t.date :dob
      t.date :date_of_appts
      t.time :time_of_appts

      t.timestamps
    end

    # Add an index on client_id for better query performance
    add_index :appointments, :client_id
  end
end
