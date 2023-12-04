class SetUserAdminAndRegisteredDefaults < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :admin, '0'
    change_column_default :users, :registered, 'false'
  end
end
