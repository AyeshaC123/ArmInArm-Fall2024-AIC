class RemoveClientsFromMembers < ActiveRecord::Migration[6.0]
  def change
    remove_index :members, column: [:client_id], name: "index_members_on_client_id"
  end
end
