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
    end
  end
end
