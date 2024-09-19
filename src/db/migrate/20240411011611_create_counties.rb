class CreateCounties < ActiveRecord::Migration[6.0]
  def change
    create_table :counties do |t|
      t.string :county_name
      t.string :state_name

      t.timestamps
    end
  end
end
