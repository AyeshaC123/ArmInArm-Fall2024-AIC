class AddPhoneNumberToClients < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:clients, :phone_number)
      add_column :clients, :phone_number, :string
    end
  end
end
