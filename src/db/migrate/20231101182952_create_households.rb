#last modified on: 4/13/24

#db file for creating a new household
class CreateHouseholds < ActiveRecord::Migration[6.0]
  def change
    create_table :households do |t|
      t.string :headname
      t.date :headdob
      t.string :headgender
      t.string :headethnicity
      t.integer :numadults
      t.integer :numchild
      t.string :pantrylocation # james: added
      t.string :streetaddr
      t.string :city
      t.string :state
      t.string :county
      t.string :zipcode
      t.string :phonenum
      t.string :incomesource
      t.string :qualifiercode
      t.integer :netincome
      t.string :householdtype
      t.string :foodstamps
      t.boolean :reviewed # added by team 11
      

      t.timestamps
    end

    # Adding a unique index to ensure headname is unique across all records - Team 13
    add_index :households, :headname, unique: false
  end
end
