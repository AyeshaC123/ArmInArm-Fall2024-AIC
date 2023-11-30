class ClientUserRelation < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :client, foreign_key: true
  end
end
