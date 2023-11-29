class ChangeBookingDaysTypeInAdminPanels < ActiveRecord::Migration[6.0]

  def up
    add_column :admin_panels, :new_booking_days, :string, array: true, default: []

    # Update existing records with valid array data or set a default value
    AdminPanel.all.each do |admin_panel|
      admin_panel.update(new_booking_days: admin_panel.booking_days || [])
    end

    remove_column :admin_panels, :booking_days
    rename_column :admin_panels, :new_booking_days, :booking_days
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
