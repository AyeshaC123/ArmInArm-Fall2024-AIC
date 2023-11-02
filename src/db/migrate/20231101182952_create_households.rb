class CreateHouseholds < ActiveRecord::Migration[6.0]
  def change
    create_table :households do |t|
      t.string :headname
      t.date :headdob
      t.string :headgender
      t.string :headethicity
      t.integer :numadults
      t.integer :numchild
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

      t.timestamps
    end
  end
end
