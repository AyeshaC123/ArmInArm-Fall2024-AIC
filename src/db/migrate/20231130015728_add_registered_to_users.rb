class AddRegisteredToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :registered, :boolean
  end
end
