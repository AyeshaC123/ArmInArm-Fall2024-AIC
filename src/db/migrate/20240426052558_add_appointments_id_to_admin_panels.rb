class AddAppointmentsIdToAdminPanels < ActiveRecord::Migration[6.0]
  def change
    add_reference :appointments, :admin_panels, foreign_key: true
  end
end
