class AddClientToMembers < ActiveRecord::Migration[6.0]
  def change
    add_reference :members, :client, null: false, foreign_key: true
  end
end
