class AllergiesOverhaul < ActiveRecord::Migration[6.0]
  def change
    # The eight common allergens recognized by the FDA.
    add_column :clients, :allergy_peanuts, :boolean
    add_column :clients, :allergy_treenuts, :boolean
    add_column :clients, :allergy_eggs, :boolean
    add_column :clients, :allergy_milk, :boolean
    add_column :clients, :allergy_shellfish, :boolean
    add_column :clients, :allergy_fish, :boolean
    add_column :clients, :allergy_wheat, :boolean
    add_column :clients, :allergy_soy, :boolean
    # Common dietary restrictions.
    add_column :clients, :gluten_free, :boolean
    add_column :clients, :vegan, :boolean
    # Remove allergies string. Any allergies not in common allergens
    # should be placed in dietary_restrictions.
    remove_column :clients, :allergies
  end
end
