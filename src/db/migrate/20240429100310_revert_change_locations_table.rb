class RevertChangeLocationsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :operating_days, :string

    remove_column :locations, :monday_hours
    remove_column :locations, :tuesday_hours
    remove_column :locations, :wednesday_hours
    remove_column :locations, :thursday_hours
    remove_column :locations, :friday_hours
    remove_column :locations, :saturday_hours
    remove_column :locations, :sunday_hours
  end
end
