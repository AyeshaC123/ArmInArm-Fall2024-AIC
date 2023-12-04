class LocaleInUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :locale, :string, default: 'en', limit: 2
  end
end
