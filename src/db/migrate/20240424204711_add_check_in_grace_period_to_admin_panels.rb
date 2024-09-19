class AddCheckInGracePeriodToAdminPanels < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_panels, :check_in_grace_period, :integer
  end
end
