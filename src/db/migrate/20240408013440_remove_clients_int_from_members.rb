class RemoveClientsIntFromMembers < ActiveRecord::Migration[6.0]
  def change
    remove_column :members, :client_id, :bigint
  end
end
