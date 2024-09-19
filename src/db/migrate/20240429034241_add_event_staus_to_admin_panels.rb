class AddEventStausToAdminPanels < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_panels, :event_active, :boolean, default: true
  end
end
