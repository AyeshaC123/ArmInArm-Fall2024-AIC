class SetDefaultPantryLocationForExistingHouseholds < ActiveRecord::Migration[6.0]
  def up
    Household.update_all(pantrylocation: "N/A")
  end
end
