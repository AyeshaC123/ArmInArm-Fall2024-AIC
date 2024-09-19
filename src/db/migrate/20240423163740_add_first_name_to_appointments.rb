class AddFirstNameToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :first_name, :string
  end
end
