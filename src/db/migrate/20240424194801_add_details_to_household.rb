class AddDetailsToHousehold < ActiveRecord::Migration[6.0]
  def up
    add_column :households, :flag, :boolean, default: false
  end
end
