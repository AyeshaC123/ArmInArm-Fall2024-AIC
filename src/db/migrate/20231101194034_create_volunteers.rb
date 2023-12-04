class CreateVolunteers < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteers do |t|
      t.string :volunteer_name
      t.string :volunteer_phone
      t.text :interests
    end
  end
end
