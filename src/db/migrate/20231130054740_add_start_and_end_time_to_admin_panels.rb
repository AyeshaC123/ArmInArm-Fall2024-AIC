class AddStartAndEndTimeToAdminPanels < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_panels, :start_time, :time
    add_column :admin_panels, :end_time, :time
  end
end
