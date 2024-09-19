class AddCheckingColumnsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :client_self_check_in, :boolean, default: false
    add_column :appointments, :check_in_user, :boolean, default: false
  end
end
