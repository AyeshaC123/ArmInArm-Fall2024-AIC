class AddMoreDetailsToAdminPanels < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_panels, :event_title, :string
    add_column :admin_panels, :start_date, :date
    add_column :admin_panels, :end_date, :date
    
    add_column :admin_panels, :location, :text, array: true, default: ["Trenton"]

    add_column :admin_panels, :re_occur, :boolean, default: true
  end
end
