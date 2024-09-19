class AddPantryLocationToHouseholds < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:households, :pantrylocation)
      add_column :households, :pantrylocation, :string, default: "N/A"
    end
  end
end
