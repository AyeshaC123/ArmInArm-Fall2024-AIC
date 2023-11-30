class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :firstname
      t.string :lastname
      t.date :dob
      t.string :relationship
      t.references :household, null: false, foreign_key: true

      t.timestamps
    end
  end
end
