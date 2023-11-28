class ChangeBookingDaysTypeInAdminPanels < ActiveRecord::Migration[6.0]
  def up
    change_column :admin_panels, :booking_days, :string, array: true, default: []
  end

  def down
    change_column :admin_panels, :booking_days, :string
  end
end
