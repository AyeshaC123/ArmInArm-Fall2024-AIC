class SetUserAdminAndRegisteredDefaults < ActiveRecord::Migration[6.0]
  def change

   # add_column :users, :admin, :integer

   # add_column :users, :admin, :integer

    #change_column_default :users, :admin, 'false'
   # change_column_default :users, :registered, 'false'
 # end


    add_column :users, :admin, :integer
    change_column_default :users, :admin, '0'
    change_column_default :users, :registered, 'false' 
 end

end
