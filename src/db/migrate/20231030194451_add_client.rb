class AddClient < ActiveRecord::Migration[6.0]
  def change
    create_table(:clients, primary_key: 'id') do |t|
      t.string :first_name
      t.string :last_name
      t.date   :dob
      t.string :address
      t.string :language
      t.string :religion
      t.string :allergies
      t.string :restrictions
      t.string :client_email
      t.string :phone_number 
      t.boolean :consent_to_msgs 
      t.string :street 
      t.string :city 
      t.string :state 
      t.string :country 
      t.string :zip_code 
      t.string :household_type
      t.string :hoh_gender
      t.string :hoh_race_ethnicity
      t.integer :num_adults 
      t.integer :num_children 
      # Additional Household Members info (name, DOB, relationship to HOH):
      t.string :non_hoh_first_name 
      t.string :non_hoh_last_name 
      t.date :non_hoh_dob 
      t.string :non_hoh_relationship 
      # Receive SNAPS? (Foodstamps):
      t.boolean :receive_snaps
      t.string :income_source
      t.string :qualifier_code
      t.integer :net_income
      t.boolean :spouse
      t.boolean :child
      t.boolean :mother
      t.boolean :father
      t.boolean :sibling
      t.boolean :grandchild
      t.boolean :grandparent
      t.boolean :niece
      t.boolean :nephew
      t.boolean :aunt
      t.boolean :uncle
      t.boolean :cousin
      t.boolean :son_in_law
      t.boolean :daughter_in_law
      t.boolean :parent_in_law
      t.boolean :friend
    end
  end
end
