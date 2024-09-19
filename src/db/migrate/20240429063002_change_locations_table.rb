class ChangeLocationsTable < ActiveRecord::Migration[6.0]
  def change
    # Check if the column exists before trying to remove it
    if column_exists?(:locations, :operating_days)
      remove_column :locations, :operating_days
    end
    add_column :locations, :monday_hours, :string
    add_column :locations, :tuesday_hours, :string
    add_column :locations, :wednesday_hours, :string
    add_column :locations, :thursday_hours, :string
    add_column :locations, :friday_hours, :string
    add_column :locations, :saturday_hours, :string
    add_column :locations, :sunday_hours, :string
  end
end
