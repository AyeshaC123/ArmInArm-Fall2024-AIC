class AddDefaultLocationToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :default_location, :string, default: "Princeton"
  end
end
